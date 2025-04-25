Return-Path: <linux-can+bounces-3482-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3089A9BEB4
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 08:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC4E4A1CA1
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 06:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0F31CB518;
	Fri, 25 Apr 2025 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mwa.re header.i=@mwa.re header.b="fsHfh106"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C31BC2A
	for <linux-can@vger.kernel.org>; Fri, 25 Apr 2025 06:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745562885; cv=none; b=ID73ilPE6VmpyHDqElchJp+4MVnUx2raXzTm6ZCaNhNkBiNiYvBvQvrxJfz+HcHi0q5wAPYoLfJyJCEVA235G///FD+xMopmVSaJHgcBBol8Y0WdDEgs41iikfwAGt5N6yhYzywvnsNKdEX13nJafGYfNJXb5/hyDOvnT7ww/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745562885; c=relaxed/simple;
	bh=RMClceeEw3Pp0PNyByhiQncZIxpsyEXKvuwaBOZuuyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qGvbGfB+zesGd2hj18qBiIoJNBFZDX46nvHER1GeRD6zJNarDBq4ifvDZebkpf0gG9PG5nUJ7pLDWI4bW0vdNk8r8AUFuKuM4b4/A09doPjp5bjgCfnNWzOeGaSimGytbDyEWRuMoCKqgonf19fSPQgHaJGVJcD28dTlPiiIRU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mwa.re; spf=pass smtp.mailfrom=mwa.re; dkim=pass (2048-bit key) header.d=mwa.re header.i=@mwa.re header.b=fsHfh106; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mwa.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mwa.re
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0618746bso13743715e9.2
        for <linux-can@vger.kernel.org>; Thu, 24 Apr 2025 23:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mwa.re; s=google; t=1745562882; x=1746167682; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ATm0YZIizzqFO6NYHckSCKHB/wQRMDp7NKOB7TkKpD4=;
        b=fsHfh106jHqDfxNlwUvWPP084ZhAH4YKb1DTm3gOHyjzxxcieJ7NudGCZL4taHqaFe
         WaOd+8BN7wv28CRSjpl+tDT8SC4nEpxJVR1VMXXSVgbNJoQ3rFn1YhrCYIhMg+ErKsxA
         7y7zQVeC3HiOU4lDIHtlzzSRv0PtLdjcRyEQh6NZbRijJhnttKD/BT/kBKcyVWvB8F31
         Q96CwPc9HmJLVU7dJ1jzX8axtb80fYa20nQxE0N4/mOMMfIL98NRwNmbTxL6o0zlvz4f
         2Sxes+1yE/yfrFxS/Y+G68DSpqyJkfjwVhrNR/d8anDcxgBIwlJ1WoCLSPqxNWb9vKMt
         V+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745562882; x=1746167682;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ATm0YZIizzqFO6NYHckSCKHB/wQRMDp7NKOB7TkKpD4=;
        b=qxPATQ3hIyqptM8pXLEQy+DAT8TsUYWgxklzy9H+wmKLgChG3waDB2XZFR+Rns7CZG
         8lf0dtkiruDf/7l9jQcw4Wc7HJeql+WnIIIBFCUYXZrDns6flBIWjBXtGEDJh4myvbGY
         XJtyA9NGez8jT6XopfSzQE/hlWqEDit4BcledLdXHJtIpcM7hNA32VhFH/XT1Tu2RYmM
         ga+Me5sQf53q5YZx2OoYv0umbX9mGqsJC5ZrFQi/AOFPveh6tHn0HgE2+V5Gg/Jg9cvH
         nKivejmY4tFKMAOI5UjHmaKkFy1clf4wHzeIFYHHV1ahoVt3a9ipjBUcRhGfy1dMBIFQ
         se0g==
X-Forwarded-Encrypted: i=1; AJvYcCWi+DITeKDMmLUXIvCpGHviVSaCPyAvkus1wwlk8WoJhovwkGPs9HydsbXUvCNYNU45i+xiGXpxTsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaFkam6McRNn2mlyTd5tfmlC0dVqKKYj62OrovF3GlKTrXVM2c
	Q4gMHWw3qGB0/GkMy/P7gK8/4kb2Mc+iGHs57sVwRHwea+FPf2TZccWm5hdUyaE=
X-Gm-Gg: ASbGncuJN3JjlTxT8G1wlujwDJWr0cgDMNmeCR34LySGelaEIu5+RfhPbelv+EJTlRK
	rwdkTLyxX5Qj4kLUMpy/cx4KSSc/1R9xf+pP65vvOU3jv0+1qtn9fGAT+qLL/nMupu3odAysYmG
	rL3p0hYE+5eei2sQ87oQ245FHGRXCZ6lei1fw+SEKQZAHYzPSrb1NqkgOBY8FoCBTSQewZMsmKj
	YaPChysOyOKv+QeGtSRaEttvdAZS9knNnpNlavdZKBnzh91RWAp0XanYvnL/XeV9Q/Y9b1+FyOO
	Awzv/U1nCP7dJPT5qBJOYHtfgHojd3OW8uPx0p4k/rZo8uJaAr7vYtKwHrrkaZkz2Dq7aGeZP/P
	F
X-Google-Smtp-Source: AGHT+IHPBT1arHfn8aZXNBeNYhIoxB+S8InwNRMy21+W9UbsMjZ0BWEzOSiZGSJc8p5mtzw9g/gcYQ==
X-Received: by 2002:a05:600c:83ca:b0:43c:fb36:d296 with SMTP id 5b1f17b1804b1-440a669b391mr7033735e9.25.1745562882041;
        Thu, 24 Apr 2025 23:34:42 -0700 (PDT)
Received: from mw-ac-stu-3.corp.mwa.re (static-195-14-251-13.nc.de. [195.14.251.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d29b8efsm47310045e9.6.2025.04.24.23.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 23:34:40 -0700 (PDT)
Message-ID: <2fe59c0c7e0f7b9369976501790fce5beaea5bc7.camel@mwa.re>
Subject: Re: [PATCH] can: m_can: initialize spin lock on device probe
From: Antonios Salios <antonios@mwa.re>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Marc Kleine-Budde
	 <mkl@pengutronix.de>
Cc: rcsekar@samsung.com, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lukas@mwa.re, jan@mwa.re, Markus
 Schneider-Pargmann	 <msp@baylibre.com>
Date: Fri, 25 Apr 2025 08:34:40 +0200
In-Reply-To: <a5684bfe-981e-4ba3-bbea-d713b5b83160@wanadoo.fr>
References: <20250424125219.47345-2-antonios@mwa.re>
	 <20250424-industrious-rottweiler-of-attack-e7ef77-mkl@pengutronix.de>
	 <a5684bfe-981e-4ba3-bbea-d713b5b83160@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-25 at 00:23 +0900, Vincent Mailhol wrote:
> Maybe you can briefly describe what kind of bug (NULL pointer
> dereference).

It's a spinlock bad magic bug that occurs when one tries to send a CAN
frame using cansend. The frame gets transferred nonetheless.
I'm testing the driver in an virtual RISC-V 64-bit environment with a
recent mainline kernel. The M_CAN controller is io-mapped to the
system.

> Also, if you have the dmesg log of the error, this is something you
> can add at
> the end of the patch description.

Will do, I'm just waiting for more feedback on the patch before sending
a v3. In the meantime, the dmesg log looks like this:

$ cansend can0 123#deadbeef
[   10.631450] BUG: spinlock bad magic on CPU#0, cansend/95
[   10.631462]  lock: 0xff60000002ec1010, .magic: 00000000, .owner:
<none>/-1, .owner_cpu: 0
[   10.631479] CPU: 0 UID: 0 PID: 95 Comm: cansend Not tainted 6.15.0-
rc3-00032-ga79be02bba5c #5 NONE
[   10.631487] Hardware name: MachineWare SIM-V (DT)
[   10.631490] Call Trace:
[   10.631493] [<ffffffff800133e0>] dump_backtrace+0x1c/0x24
[   10.631503] [<ffffffff800022f2>] show_stack+0x28/0x34
[   10.631510] [<ffffffff8000de3e>] dump_stack_lvl+0x4a/0x68
[   10.631518] [<ffffffff8000de70>] dump_stack+0x14/0x1c
[   10.631526] [<ffffffff80003134>] spin_dump+0x62/0x6e
[   10.631534] [<ffffffff800883ba>] do_raw_spin_lock+0xd0/0x142
[   10.631542] [<ffffffff807a6fcc>] _raw_spin_lock_irqsave+0x20/0x2c
[   10.631554] [<ffffffff80536dba>] m_can_start_xmit+0x90/0x34a
[   10.631567] [<ffffffff806148b0>] dev_hard_start_xmit+0xa6/0xee
[   10.631577] [<ffffffff8065b730>] sch_direct_xmit+0x114/0x292
[   10.631586] [<ffffffff80614e2a>] __dev_queue_xmit+0x3b0/0xaa8
[   10.631596] [<ffffffff8073b8fa>] can_send+0xc6/0x242
[   10.631604] [<ffffffff8073d1c0>] raw_sendmsg+0x1a8/0x36c
[   10.631612] [<ffffffff805ebf06>] sock_write_iter+0x9a/0xee
[   10.631623] [<ffffffff801d06ea>] vfs_write+0x184/0x3a6
[   10.631633] [<ffffffff801d0a88>] ksys_write+0xa0/0xc0
[   10.631643] [<ffffffff801d0abc>] __riscv_sys_write+0x14/0x1c
[   10.631654] [<ffffffff8079ebf8>] do_trap_ecall_u+0x168/0x212
[   10.631662] [<ffffffff807a830a>] handle_exception+0x146/0x152

--=20
Antonios Salios
Software Engineer

MachineWare GmbH | www.machineware.de
H=C3=BChnermarkt 19, 52062 Aachen, Germany
Amtsgericht Aachen HRB25734

Gesch=C3=A4ftsf=C3=BChrung
Lukas J=C3=BCnger
Dr.-Ing. Jan Henrik Weinstock

