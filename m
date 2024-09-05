Return-Path: <linux-can+bounces-1415-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C25D96CC48
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 03:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944A51C219AC
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 01:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA096FDC;
	Thu,  5 Sep 2024 01:30:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30C49463;
	Thu,  5 Sep 2024 01:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725499840; cv=none; b=Du3UxXgKEYvUjxjJfPIqBDBnR27NmWvz+6aJoBohlI6yv0oV7WOGEETwrtQ45rLluHQIHJvQvJQQGFtITDsabDySgOShItRxbS8hOc6kSn6kQM+ldYWe4KtyDUXfzH4GLFpE6fAlBYjxstAZWeb2TDooKpfW+21PX5QdTzD8RlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725499840; c=relaxed/simple;
	bh=9Pmrj+fcoaD/YRwU9h2tnyj5nQnnVuZkdkK9DiZxhww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9a69PShlZoZh2VBVmctbi4ZqBKwgXpfyKj2CVbr7hZ7hNUvRNRrcoWL4iR5jN1TdpQRsrcN09ADHisEpxYsZZ+QmtXJIJtiLcCPvB6bX5cgK9iYqqknUhTFtw+uvM3pcpR4o6db5Kc6FHMjWJmjZL4QjhUTuT6TDGUYQs62JA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso208815a12.2;
        Wed, 04 Sep 2024 18:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725499838; x=1726104638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJolQwf1euELjkMn06jCNPYIcnCPKJMA8NUSas5Qbjg=;
        b=sRuGE6MC+USxdEm80YbAnU4miXIyU/bn90kcjh/mhI2lQtRAhsGg260CvkAk1lLcpD
         MwP1X+zTGZmNfPeiw2RMcSSOgZGMO7IgcU+6eDbKUatNJlydcQz/Q4T74dSVjmPCIlna
         xk2E8e4SDzXERhqzdYY0CJOUR+vEy/LtUzVfwPs1G6ObaqcY/v+332lDOM6wT+7ru3kK
         /AWx4ZeKh4YanpXiVpiYG7bViGpgAaNk8hHhLgr9uARoy0xAp7Xa3An2kl14yN/ilVGd
         EZN12T0IkkfDS8aIPpxOWzY9UHTdCD6G0MX1C9fuYvXX8MklclHPVYzpHEqv9Y2epQGq
         OvNA==
X-Forwarded-Encrypted: i=1; AJvYcCUHcATeHvuyq3EauKCnsXFHIYCJ4J5Z/DFEIv3WkytU6lrVGixX/lAZZZMzFQRDKRLvV/DP9ijY1Og=@vger.kernel.org, AJvYcCVvgw4jBZVLYZ0VT+xtO67Ffm4nGYW5MtHARdnWtpGA91ODCMjJKlqmSuR3vTaOsnHvnVn9fQUJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyNNntk0VLAVsVeV6960OqtKGB9JoKrnp6uxte1rwKFgmRCL6yR
	ONKt93uvWRoY26E/378G8IL7nX0mlAy8/2PR8crVFHkTvvUPgUOz5uvAycZ2LVC+3cRuOiIgxeU
	MriwNF5/FkWFx/ZcRF6CEprHlGfIECYcd
X-Google-Smtp-Source: AGHT+IES+cBXzaSvaSBSS51KD767JrfrVi6K/CaNSezsDz6Yl9Ze9TEs8wEG3i7JpoGVhJsrQ7EWZQl1xJjt1nPcd0U=
X-Received: by 2002:a05:6a21:2d8b:b0:1cf:1218:ea07 with SMTP id
 adf61e73a8af0-1cf1218ed72mr1861244637.5.1725499838153; Wed, 04 Sep 2024
 18:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905012237.79683-1-kuniyu@amazon.com>
In-Reply-To: <20240905012237.79683-1-kuniyu@amazon.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Thu, 5 Sep 2024 10:30:26 +0900
Message-ID: <CAMZ6RqLHbxdda_CLg-_N-WN8zxjWOaDQ2qOck8-Xj-6Myjh1Qg@mail.gmail.com>
Subject: Re: [PATCH v1 can] can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-can@vger.kernel.org, 
	syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Iwashima san,

Thank you for your patch.

On Thu. 5 Sep. 2024 at 10:24, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> syzbot reported a warning in bcm_release(). [0]
>
> The blamed change fixed another warning that is triggered when
> connect() is issued again for a socket whose connect()ed device has
> been unregistered.
>
> However, if the socket is just close()d without the 2nd connect(), the
> remaining bo->bcm_proc_read triggers unnecessary remove_proc_entry()
> in bcm_release().
>
> Let's clear bo->bcm_proc_read after remove_proc_entry() in bcm_notify().
>
> [0]
> name '4986'
> WARNING: CPU: 0 PID: 5234 at fs/proc/generic.c:711 remove_proc_entry+0x2e7/0x5d0 fs/proc/generic.c:711
> Modules linked in:
> CPU: 0 UID: 0 PID: 5234 Comm: syz-executor606 Not tainted 6.11.0-rc5-syzkaller-00178-g5517ae241919 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> RIP: 0010:remove_proc_entry+0x2e7/0x5d0 fs/proc/generic.c:711
> Code: ff eb 05 e8 cb 1e 5e ff 48 8b 5c 24 10 48 c7 c7 e0 f7 aa 8e e8 2a 38 8e 09 90 48 c7 c7 60 3a 1b 8c 48 89 de e8 da 42 20 ff 90 <0f> 0b 90 90 48 8b 44 24 18 48 c7 44 24 40 0e 36 e0 45 49 c7 04 07
> RSP: 0018:ffffc9000345fa20 EFLAGS: 00010246
> RAX: 2a2d0aee2eb64600 RBX: ffff888032f1f548 RCX: ffff888029431e00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000345fb08 R08: ffffffff8155b2f2 R09: 1ffff1101710519a
> R10: dffffc0000000000 R11: ffffed101710519b R12: ffff888011d38640
> R13: 0000000000000004 R14: 0000000000000000 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fcfb52722f0 CR3: 000000000e734000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  bcm_release+0x250/0x880 net/can/bcm.c:1578
>  __sock_release net/socket.c:659 [inline]
>  sock_close+0xbc/0x240 net/socket.c:1421
>  __fput+0x24a/0x8a0 fs/file_table.c:422
>  task_work_run+0x24f/0x310 kernel/task_work.c:228
>  exit_task_work include/linux/task_work.h:40 [inline]
>  do_exit+0xa2f/0x27f0 kernel/exit.c:882
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1031
>  __do_sys_exit_group kernel/exit.c:1042 [inline]
>  __se_sys_exit_group kernel/exit.c:1040 [inline]
>  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
>  x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fcfb51ee969
> Code: Unable to access opcode bytes at 0x7fcfb51ee93f.
> RSP: 002b:00007ffce0109ca8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fcfb51ee969
> RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
> RBP: 00007fcfb526f3b0 R08: ffffffffffffffb8 R09: 0000555500000000
> R10: 0000555500000000 R11: 0000000000000246 R12: 00007fcfb526f3b0
> R13: 0000000000000000 R14: 00007fcfb5271ee0 R15: 00007fcfb51bf160
>  </TASK>
>
> Fixes: 76fe372ccb81 ("can: bcm: Remove proc entry when dev is unregistered.")
> Reported-by: syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0532ac7a06fb1a03187e
> Tested-by: syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

