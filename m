Return-Path: <linux-can+bounces-847-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76083913C57
	for <lists+linux-can@lfdr.de>; Sun, 23 Jun 2024 17:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFC01F22808
	for <lists+linux-can@lfdr.de>; Sun, 23 Jun 2024 15:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD6917FACE;
	Sun, 23 Jun 2024 15:29:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6990B125D6
	for <linux-can@vger.kernel.org>; Sun, 23 Jun 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719156566; cv=none; b=tz2jIjRi93bs/K1v6YXKONjr6EOu4j6KRVzIPwu9ipMbvJc/JstGsfOBAvPN5tl4kdFtcIF2itogenFh7h5f6vdIP/FSCk0SiiPBo1/OLxeRXG0JOUjtRZ53xrAcXxwRFLCXJ3dwv3pRiviVlJK6UwyGpZybaZsrL5V3H9Vt3/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719156566; c=relaxed/simple;
	bh=5GzQNXCfF8EdbfC3H4E9VS+tvgTWS1crHKs96+wLw5I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ro0hnM4ptuPgCLMbcH2xYiAtmt9XCLGocKQu3wBX+UbR3EfVJi4HLk3jtC7jpyVdQTltqz5gxnsusNPu1ujB8YmcYJmF46v8gCpEtSIxk1mpE2Jx1laFuURIYyYtn+IcU67jE6Adq3h2K2Z1yh2HBX4rCSpBloiRVeaBDuYe6E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-37642e69d7eso5401055ab.3
        for <linux-can@vger.kernel.org>; Sun, 23 Jun 2024 08:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719156564; x=1719761364;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EP0r5vjIqTOj5wt9p5RxoVOv4/EypeRrWumP8Iu8xTU=;
        b=j20/XsaVRyMEokwyD68L+4klaGS5QLmiWyxq6lu6pe/rItkChacfZTjCxP1q3ra1LQ
         oniTg7DzQ4i3J2N6FnPYHXaj0QmAI7DGAvYrEriZiBB5l59PkO3LWMjeBxNufSrFmXtR
         ZiZTQIckDDlp9MTyNZhBHZK6bLF2Yy3POOoZiJcAvmifLJfLpExXXMeoZ/u3RndaAH1w
         TVi9+OheSPZX8x2nUDPmeBsdmbi+HYuaySvyAYe/oIbaFJM+QEDoFnS2jKzmbELAQC9b
         9J7xZRXJaVK/2eD8PpRj1FtIxndmX69S7tWag8qtFk5G1ARp/4MpyN0jZbResmZmJqRX
         bD6w==
X-Forwarded-Encrypted: i=1; AJvYcCWGdtWH0ZIte1ERAWfOZTqJXa3H8RRyJOKtGMVfXFU1H/fCSZdifPXfDM1UCFjqQTE8wRm85C0zW3AwReo4g8vrHaoQhcqlAMoN
X-Gm-Message-State: AOJu0Yxl+LX3xMMCuesFKIv+vcMPxiKzMmysq464bvXKAzCpoDeYHWa+
	VMq0A+9tDg9LkJjH4CoZB1Egz+Tz+GfekrALcoL3yY1aISV58pSlMo1aGLp7TxmGyVPJlDIeuyr
	0Px1vcwa3qJnBy+ZSNmzMabOPH76xWTXk9ZL7zy1mKInXJnVGA/xoKl8=
X-Google-Smtp-Source: AGHT+IFqnPdpAhkaCMlzEMZuVA/C2S6JDfh8pY3BlYKXaqSV5TpYTSaMd5hwBP7t8YgYtHTf5gVQGwAtwWvzgO6DJ3GECpny+vp9
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd84:0:b0:36c:4b17:e05d with SMTP id
 e9e14a558f8ab-3763e16d8a6mr3431835ab.4.1719156564589; Sun, 23 Jun 2024
 08:29:24 -0700 (PDT)
Date: Sun, 23 Jun 2024 08:29:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000589156061b90544f@google.com>
Subject: [syzbot] [can?] INFO: task hung in cangw_pernet_exit_batch (3)
From: syzbot <syzbot+21ad8c05e3792b6ffd14@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, mkl@pengutronix.de, 
	netdev@vger.kernel.org, pabeni@redhat.com, socketcan@hartkopp.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16dd1f2e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
dashboard link: https://syzkaller.appspot.com/bug?extid=21ad8c05e3792b6ffd14
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/27e64d7472ce/disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e1c494bb5c9c/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/752498985a5e/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+21ad8c05e3792b6ffd14@syzkaller.appspotmail.com

INFO: task kworker/u8:1:12 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:1    state:D stack:18160 pid:12    tgid:12    ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 cangw_pernet_exit_batch+0x20/0x90 net/can/gw.c:1257
 ops_exit_list net/core/net_namespace.c:178 [inline]
 cleanup_net+0x89f/0xcc0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:6:5181 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:6     state:D stack:20976 pid:5181  tgid:5181  ppid:2      flags:0x00004000
Workqueue: events_power_efficient crda_timeout_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 crda_timeout_work+0x15/0x50 net/wireless/reg.c:540
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

