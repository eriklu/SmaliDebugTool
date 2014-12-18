.class public Ldebug/DebugTool$ThreadStack;
.super Ljava/lang/Object;
.source "DebugTool.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ldebug/DebugTool;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "ThreadStack"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 146
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static getThreadStack()Ljava/lang/String;
    .locals 8

    .prologue
    .line 161
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v3

    .line 162
    .local v3, "t":Ljava/lang/Thread;
    invoke-virtual {v3}, Ljava/lang/Thread;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v2

    .line 163
    .local v2, "stacks":[Ljava/lang/StackTraceElement;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 164
    .local v0, "sb":Ljava/lang/StringBuilder;
    array-length v5, v2

    const/4 v4, 0x0

    :goto_0
    if-lt v4, v5, :cond_0

    .line 167
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    return-object v4

    .line 164
    :cond_0
    aget-object v1, v2, v4

    .line 165
    .local v1, "stack":Ljava/lang/StackTraceElement;
    invoke-virtual {v1}, Ljava/lang/StackTraceElement;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "\n"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 164
    add-int/lit8 v4, v4, 0x1

    goto :goto_0
.end method

.method public static log2File()V
    .locals 1

    .prologue
    .line 153
    invoke-static {}, Ldebug/DebugTool$ThreadStack;->getThreadStack()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ldebug/DebugTool;->log2File(Ljava/lang/String;)V

    .line 154
    return-void
.end method

.method public static log2FileThreadStack(Ljava/lang/String;)V
    .locals 1
    .param p0, "filename"    # Ljava/lang/String;

    .prologue
    .line 157
    invoke-static {}, Ldebug/DebugTool$ThreadStack;->getThreadStack()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Ldebug/DebugTool;->log2File(Ljava/lang/String;Ljava/lang/String;)V

    .line 158
    return-void
.end method

.method public static logcat()V
    .locals 1

    .prologue
    .line 149
    invoke-static {}, Ldebug/DebugTool$ThreadStack;->getThreadStack()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ldebug/DebugTool;->logcat(Ljava/lang/String;)V

    .line 150
    return-void
.end method
