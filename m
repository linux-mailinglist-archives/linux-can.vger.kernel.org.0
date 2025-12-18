Return-Path: <linux-can+bounces-5883-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E67E8CCD7B0
	for <lists+linux-can@lfdr.de>; Thu, 18 Dec 2025 21:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23D693027E21
	for <lists+linux-can@lfdr.de>; Thu, 18 Dec 2025 20:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E2A2C0F92;
	Thu, 18 Dec 2025 20:12:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632352BDC0F
	for <linux-can@vger.kernel.org>; Thu, 18 Dec 2025 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088748; cv=none; b=hNuxMDxQWOiXVnsaDgf1x/mpyIshQvJpYHfYgRidLXmPhnM54Evrh7kFb5pi2kyXxXrlfLyaiqSuzbPwFmzHK5XkaTFJ8YrbSOMAOAI3MvdMe6hg1tFueOdmeBTLZ5eN89EUZOoRdsldGNh14q1dJuC1nb2qyAPJywhUMTGvtLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088748; c=relaxed/simple;
	bh=SCmrBCTDFD5ubTjkA56SqENcQgdXvnofAPhlNZPj5ic=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NlVjC2ly92wqmNJbj7nqB3/IjiP6BxfnY38CMQwhYJLsmraazb+CuyEdlDroRpSGeWP18J78WzW0x41JAzMgVL4byl1rp5BlkDKvWKQh2mvLod73M9KCc+iODTbIuERyppza/zhwh9RuM6GjygbET0FWeW7ZZW8kuzLqAJ35WYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7c7028db074so1938650a34.1
        for <linux-can@vger.kernel.org>; Thu, 18 Dec 2025 12:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766088745; x=1766693545;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tfr7FL5pZakXGk7tny8jsZuMcDvYO9J0q/4MvmwyG2E=;
        b=YsnaMXQ+Htc2DOOVrnm4wGzriBVdvZkUfcAavjKl/wfuHRaXI7gZ5BrKYjfmt6XsUz
         aSh61GmAAFbSZeG1sogpEH/xk2hw1LH38ei8MX0jIMjtQ/QVyRIgqVMDGUZbuuYRE/a+
         wwrvhPm4Bj4XMPuAMmZOhCecZriByWrKAiOTDcdYXfUuLFeh02OEjsMJttojv78Ty0io
         cUNVVwC8Ekw9exVBHvxhLvenlji+UpgK3deaG4KnPFhobIxglZLhgjAmZ1JJuFc+A8I6
         JhMpi6haYTFJ9/7SzelvascUW6oBqd7znaLHhRMrFthzaAOE17Rk744lrG9bKnSt6N8u
         XtGg==
X-Gm-Message-State: AOJu0YzjbAFzNF1JrrRj/zbpzieE4jfdl2lyiwGjNiL3cQYqj9DKXODk
	AI6q9bUBL/bliy7B5x2GVWyDXvZiJjq8b1UHUwPTJpB8xU/VIlx5TMaM8i7Z8RNp9hDnltBM92Z
	mUMzxwSv19+N7Cnv/FI5fTi/PBlfwS4l0idwDkIw3PTk/s/qJbRGXXXr1eZFLWA==
X-Google-Smtp-Source: AGHT+IFDkWTsNoL3eU9I8Uu1JnhOI/l/+UygD1nN4dlXSN/0peBnV6HtRg2gNSDhC8VnFI3q2nIbSMXl8S0hJ/OeGZGikFDiCT6M
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4289:b0:657:4733:dde with SMTP id
 006d021491bc7-65d0e94d6c4mr252189eaf.8.1766088745350; Thu, 18 Dec 2025
 12:12:25 -0800 (PST)
Date: Thu, 18 Dec 2025 12:12:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69446029.a70a0220.207337.00f1.GAE@google.com>
Subject: [syzbot] [can?] INFO: task hung in cangw_pernet_exit_batch (5)
From: syzbot <syzbot+6461a4c663b104fd1169@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, socketcan@hartkopp.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f7aa3d3c732 Merge tag 'net-next-6.19' of git://git.kernel..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=175489b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e5198eaf003f1d1
dashboard link: https://syzkaller.appspot.com/bug?extid=6461a4c663b104fd1169
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139e99c2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5fe312c4cf90/disk-8f7aa3d3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c7a1f54ef730/vmlinux-8f7aa3d3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/64a3779458bb/bzImage-8f7aa3d3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6461a4c663b104fd1169@syzkaller.appspotmail.com

INFO: task syz.0.17:6104 blocked for more than 148 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:25440 pid:6104  tgid:6104  ppid:5956   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
 __mutex_lock_common kernel/locking/mutex.c:692 [inline]
 __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
 cangw_pernet_exit_batch+0x20/0x90 net/can/gw.c:1288
 ops_exit_list net/core/net_namespace.c:205 [inline]
 ops_undo_list+0x525/0x990 net/core/net_namespace.c:252


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

