Return-Path: <linux-can+bounces-1186-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD4394D489
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2024 18:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A596B2289D
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2024 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA78B18C08;
	Fri,  9 Aug 2024 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta1AGoyt"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FBC1870;
	Fri,  9 Aug 2024 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220505; cv=none; b=WxHjphEm7bKY152KCE3ExMNnhSAB5JJE2thouuP6cHjZSCPPYHsItdjmFYU+HSB05PWsZv4z62E7K+Nl8iQa5wS8g6RogBF7AXjqskpAExH7Kc5J+B7cafDnOHRpv8b7S2n1eLNfMOcsIuAeyZlnvAy0w5G0xVCbBEi9reOpkTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220505; c=relaxed/simple;
	bh=tAsNHQqY6WPl5IiY6NLTQwXTBkmxYgDubnsHAW4O1VA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hfeN8exqhwaa+7FvQGfL1yZ7CzSKLvEqlG4lfttgB4zrs7YXeHcV7Zngsp4bPqTbA0P4asKrMbDnFIrmQz2g9B4U71XDjnRxLF/rrphqKqDaqpxA94L8pMtDwT9NPcMZK/pR1dl770b/ikEMJNeJ/9FyGS8KgSqZhcbUXOiL2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ta1AGoyt; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8270e081100so719521241.2;
        Fri, 09 Aug 2024 09:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723220503; x=1723825303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dNQlxQEsZ7AioP6IPWIOWjIBnVJQhFz2AEVk5oB8sI=;
        b=Ta1AGoytjp/Hu8y3wFyudLDaKjvv9D1QQsHp13eU3zWYFCT/7VkqGxupg7UTTdTraL
         FNwI1FWf48bI0gaEFHQfUlaj/lMJGtLA4/YeiTnc9HXtjSIvbAGiZtNLiDsa8FkPDlcv
         8zySda8iQsmzV4YHb4JMoWt9ipFrEwmttJADBFfy5sioyHxZ3dmBWTUj86zxR7v+mp9Z
         m9fnWFB7eOPPa3cLmjoIQhTSdL98GTHRZeJi5h3InCq8vHy5GTtqAIXcZnWIiNhHZ6xc
         W7Ph9z8uEJL22OSxkFFn0N5V9CjUA/RRNB+d1m85h8vQrG/bXdryQOAoL4aYPwU1/iN6
         XQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723220503; x=1723825303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dNQlxQEsZ7AioP6IPWIOWjIBnVJQhFz2AEVk5oB8sI=;
        b=BUFz6ie9YgnJwvN8N/GjPMbuytO/4VWPDIiNO18C1RsWZldCdtS60WdV3J1N3uIVc8
         csD1wJRoEL/mJpIj3fhKKW2cviYClJorYOfpdvYItVk+EAbRnUBdDcKB6l3Pe6tK2bl1
         u4UyZCfVX684b8bzIHNk1pKO7tIo0cFcnLIQmJsaGAOKMpq32sfQU7Fvr3e/4sL58JNI
         zLSnfsMRS7S7zNzk18ZRh9cSPDFK1OA7bEgk3ykbXzIKgNTvnKvleTjB2cp61SkxYAYJ
         4D3qnjj+LIZrjmp/3hnQVomZwo++j5JHvI5WAY9hNv5P7LUgWfV7ZlmiHTe2YiHA+8A7
         66Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXqkL9NZLdwp29U45ssBDECdswnWAgP22gXFpYSTp2182Rxvyt1dhnfIPf7cEc2vTIR/zCNt8BQRTKmnDRXOZDHchgv4EE4XHmsTb6WLdwP3IcdY8st0cxsQhYA3h6wIrEKszK5pjEW9qFoKPTJZ0uTDJUU1bG6vCNal8NHvMcJ
X-Gm-Message-State: AOJu0Ywux9lmIJkY6thO5nQX6B5c5G05VvsLCJP32DeOvXOM50DoX1Vw
	sRAsKlnhCeqa15+p/efWsuU6IHc+j3YVx2q2Yxxd6fluNTucLmVO
X-Google-Smtp-Source: AGHT+IEnpTJcFNeKSmLDz29//kst6PL6XWIXCIaR7BGQIptjNhNvCWRcv7qBBsZTYiBIAYH/f6BtBQ==
X-Received: by 2002:a05:6122:31a7:b0:4f6:ae65:1e10 with SMTP id 71dfb90a1353d-4f912bf4cd7mr2638873e0c.4.1723220502795;
        Fri, 09 Aug 2024 09:21:42 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f8a1a7ef02sm2008740e0c.26.2024.08.09.09.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:21:42 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: socketcan@hartkopp.net
Cc: davem@davemloft.net,
	david.hunter.linux@gmail.com,
	edumazet@google.com,
	javier.carrasco.cruz@gmail.com,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mkl@pengutronix.de,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH 1/1] Net: bcm.c: Remove Subtree Instead of Entry
Date: Fri,  9 Aug 2024 12:21:41 -0400
Message-Id: <20240809162141.139935-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2bf44b8d-b286-4a94-8e1d-6c4e736a1d07@hartkopp.net>
References: <2bf44b8d-b286-4a94-8e1d-6c4e736a1d07@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Oliver, 

> What did you do to trigger the warning? 

I am in the Linux Kernel Internship Program for the Linux Foundation. Our goal is to fix outstanding bugs with the kernel. I found the following bug on syzbot: 

https://syzkaller.appspot.com/bug?extid=df49d48077305d17519a

This specific link is for a separate issue that I will soon send a separate patch for; however, I found the bug for this patch after I switched the command parameter for panic_on_warn to 0. 

If you wish to reproduce the error, you can do the following steps: 
	1) compile and install a kernel with the config file from the link
	2) pass kernel paramter panic_on_warn=0
	3) build and run the C reproducer for the bug. 

As best as I can tell, the C reproducer simply made a system call that resulted in the bcm-can directry entry being deleted. I am still wrapping my head around the code (I am new to kernel programming), but here is the full stacktrace. 

156.449047][   T71] Call Trace:
[  156.450067][   T71]  <TASK>
[  156.451076][   T71]  ? show_regs+0x84/0x8b
[  156.452490][   T71]  ? __warn+0x150/0x29e
[  156.453754][   T71]  ? remove_proc_entry+0x335/0x385
[  156.456485][   T71]  ? report_bug+0x33d/0x431
[  156.457994][   T71]  ? remove_proc_entry+0x335/0x385
[  156.459845][   T71]  ? handle_bug+0x3d/0x66
[  156.461230][   T71]  ? exc_invalid_op+0x17/0x3e
[  156.462672][   T71]  ? asm_exc_invalid_op+0x1a/0x20
[  156.464282][   T71]  ? __warn_printk+0x26d/0x2aa
[  156.465759][   T71]  ? remove_proc_entry+0x335/0x385
[  156.467233][   T71]  ? remove_proc_entry+0x334/0x385
[  156.468821][   T71]  ? proc_readdir+0x11a/0x11a
[  156.470122][   T71]  ? __sanitizer_cov_trace_pc+0x1e/0x42
[  156.471697][   T71]  ? cgw_remove_all_jobs+0xa5/0x16f
[  156.474096][   T71]  canbcm_pernet_exit+0x73/0x79
[  156.476732][   T71]  ops_exit_list+0xf1/0x146
[  156.478358][   T71]  cleanup_net+0x333/0x570
[  156.479856][   T71]  ? setup_net+0x7ba/0x7ba
[  156.481479][   T71]  ? process_scheduled_works+0x652/0xbab
[  156.483592][   T71]  process_scheduled_works+0x7b8/0xbab
[  156.486039][   T71]  ? drain_workqueue+0x33b/0x33b
[  156.487841][   T71]  ? __sanitizer_cov_trace_pc+0x1e/0x42
[  156.489742][   T71]  ? move_linked_works+0x9f/0x108
[  156.491376][   T71]  worker_thread+0x5bd/0x6cc
[  156.492877][   T71]  ? rescuer_thread+0x64d/0x64d
[  156.494350][   T71]  kthread+0x30a/0x31e
[  156.495769][   T71]  ? kthread_complete_and_exit+0x35/0x35
[  156.497977][   T71]  ret_from_fork+0x34/0x6b
[  156.499734][   T71]  ? kthread_complete_and_exit+0x35/0x35
[  156.501494][   T71]  ret_from_fork_asm+0x11/0x20

> Removing this warning probably does not heal the root cause of the issue.

I would love to work on the root cause of the issue if at all possible. Do you think that the C reproducer went down an unlikely avenue, and therefore, further work is not needed, or do you think that this is an issue that requires some attention? 

I appreciate the response to my patch. I am learning a lot. 

Thanks, 
David

