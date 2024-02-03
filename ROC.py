import pandas as pd
from lazypredict.Supervised import LazyClassifier
import matplotlib.pyplot as plt

# 从Excel文件中读取数据
df = pd.read_excel('ROC.xlsx')  # 替换为您的Excel文件路径

# 提取模型的标签和预测得分数据
model_labels = df['Model']  # 替换为包含模型标签的列名
y_true = df['True Labels']  # 替换为包含真实标签的列名
y_scores = df['Predicted Scores']  # 替换为包含预测得分的列名

# 初始化指标列表
model_names = []
accuracy_scores = []
precision_scores = []
recall_scores = []
f1_scores = []

# 初始化 LazyClassifier
clf = LazyClassifier()

# 遍历每个模型
for model_label in model_labels.unique():
    # 提取当前模型的真实标签和预测得分
    model_y_true = y_true[model_labels == model_label]
    model_y_scores = y_scores[model_labels == model_label]
    
    # 使用 LazyClassifier 自动评估多个模型
    clf.fit(model_y_scores.values.reshape(-1, 1), model_y_true)
    clf_summary = clf.summary()
    
    # 从 LazyClassifier 的评估结果中提取指标
    model_summary = clf_summary[clf_summary.index == model_label]
    accuracy = model_summary['Accuracy'].values[0]
    precision = model_summary['Precision'].values[0]
    recall = model_summary['Recall'].values[0]
    f1 = model_summary['F1 Score'].values[0]
    
    # 添加到指标列表
    model_names.append(model_label)
    accuracy_scores.append(accuracy)
    precision_scores.append(precision)
    recall_scores.append(recall)
    f1_scores.append(f1)

# 创建数据框
data = {
    'Model': model_names,
    'Accuracy': accuracy_scores,
    'Precision': precision_scores,
    'Recall': recall_scores,
    'F1': f1_scores
}
metrics_df = pd.DataFrame(data)

# 绘制条形图
metrics_df.set_index('Model').plot(kind='bar', figsize=(10, 6))
plt.title('Model Evaluation Metrics')
plt.ylabel('Score')
plt.xlabel('Model')
plt.xticks(rotation=45)
plt.tight_layout()

# 显示图形
plt.show()

