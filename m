Return-Path: <linux-can+bounces-142-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465F8835F30
	for <lists+linux-can@lfdr.de>; Mon, 22 Jan 2024 11:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB50286DDA
	for <lists+linux-can@lfdr.de>; Mon, 22 Jan 2024 10:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73273A1A1;
	Mon, 22 Jan 2024 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ttRHrzSQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q9/Pq3uc"
X-Original-To: linux-can@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E63A1A0
	for <linux-can@vger.kernel.org>; Mon, 22 Jan 2024 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918241; cv=none; b=rw7TeXR2JxPN4QAKs/AKxQOsj6Zj1S2H66Gk5YoDVhridhjYJok0LkclUNbgTwabdsCXzbgpb5yhyeavogumBv2vGBs3HwyGOZivyESV4mkMATvBaIAK3aEQDs1A6niIAJw8Gw+4E8+DXvzQhc+Knm7VSr36EMkt0M6FvYgxFoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918241; c=relaxed/simple;
	bh=rOcLcM7e8FPr4synSzFpHQXMQ15yIgdLANif/ZbmPKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnX/yA7uCuLfvd8coUS9ryFWuqEp7/KgdXBgRlsXLl63WlJS4+PZ4vi92ynsojjVLRAyRnqaOMcf+jPcrYQqW55AQxZcqtyWRIDqRdokA6y7P02G9KEsE1fx5A5Y8M53o0IkPsY7WjnmNXZ94kKMWkvXImrBL6ZYaPJZc4rnSoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ttRHrzSQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q9/Pq3uc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Jan 2024 11:10:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705918238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KvY9S5NUgx6U3aVLlv4QKAa9TpY/R29TO6HgqpItwaQ=;
	b=ttRHrzSQ2106ZkAIc25kjVrrZ6b5qZBPmcPU/HJNObOQaKx6RK5+qxncgkMIKyohQRV+gy
	tVXBgHLMASKPn7WXBt04ZyG/9t7zhJE6izTaxTBpRLzfNzIE3vcqmpGe+/kxPbxABw6y3V
	i2yOcdmCQtPneoxlV+Yn3SaQn+X7UMrpgdRzBeZ4vmt6G4T6v11YPnRuVcBeTgGxCB/xmZ
	/cQ6VA8z7aY1KHCkB000aG8C9qTJOjrnP0vz4bpHseAHYDnjhO/eJxvjleqagsk2qg7xmK
	M73S47lJyyGicnscdqA1lyr0Maxki4C3dkX2WlkVMrutionL6ZntZC5Kbw5/IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705918238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KvY9S5NUgx6U3aVLlv4QKAa9TpY/R29TO6HgqpItwaQ=;
	b=q9/Pq3uchud/OeCH30eBYZh8PmSEqn7Ym9mJO5GCBc+pe/Y7eBDToI1+10B1HHn7lASH22
	lMDiKfnlgmq8ZCDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, tglx@linutronix.de
Subject: Re: [RFC PATCH] can: gw: fix RCU/BH usage in cgw_create_job()
Message-ID: <20240122101037.FnYaYf7_@linutronix.de>
References: <20231221123703.8170-1-socketcan@hartkopp.net>
 <20240111121402.xc9rmYfG@linutronix.de>
 <b42b9988-98b5-411a-8493-b9d3d534c7d7@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b42b9988-98b5-411a-8493-b9d3d534c7d7@hartkopp.net>

On 2024-01-21 11:07:34 [+0100], Oliver Hartkopp wrote:
> On 2024-01-11 13:14, Sebastian Andrzej Siewior wrote:
> 
> > Why are you afraid of doing
> > 	mod = kmalloc(sizeof(*mod), GFP_KERNEL);
> > 
> > before invoking cgw_parse_attr()?
> 
> The update of the modification content should be performed instantly and
> without any potential scheduling from kmalloc().

In most cases, the memory would be acquired without a delay. But if the
memory is tight it will get delayed over returning a NULL pointer and
(depending on the size) the NULL pointer can still be returned.
This code path is preemptible so the scheduler _can_ preempt the code in
favour of another task.

> As you pointed out one of the problems may arise from changing the
> modification functions but not from changing the modification content.
> 
> So what about the below patch then?

Well, you do change parts of the data structure while the other side can
read it so I would say no. Also, in general there is no guarantee if the
memcpy() implementation copies the data from front or the end. 

> Would a spin_lock() or spin_lock_bh() be an alternative to lock this update
> against the modification execution in can_can_gw_rcv()?

Yes, that is what locks are for. You would have to put the lock outside
of ccgw and acquire it before reading or writting ccgw.

> Best regards,
> Oliver

Sebastian

