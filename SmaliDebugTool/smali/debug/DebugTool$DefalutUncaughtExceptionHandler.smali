.class Ldebug/DebugTool$DefalutUncaughtExceptionHandler;
.super Ljava/lang/Object;
.source "DebugTool.java"

# interfaces
.implements Ljava/lang/Thread$UncaughtExceptionHandler;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ldebug/DebugTool;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "DefalutUncaughtExceptionHandler"
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 308
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public uncaughtException(Ljava/lang/Thread;Ljava/lang/Throwable;)V
    .locals 1
    .param p1, "thread"    # Ljava/lang/Thread;
    .param p2, "ex"    # Ljava/lang/Throwable;

    .prologue
    .line 313
    invoke-static {}, Ldebug/DebugTool$ThreadStack;->logcat()V

    .line 314
    invoke-static {}, Ldebug/DebugTool$ThreadStack;->log2File()V

    .line 315
    invoke-virtual {p2}, Ljava/lang/Throwable;->getLocalizedMessage()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ldebug/DebugTool;->log2File(Ljava/lang/String;)V

    .line 316
    return-void
.end method
