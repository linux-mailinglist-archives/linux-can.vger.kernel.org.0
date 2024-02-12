Return-Path: <linux-can+bounces-228-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2E8851892
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 16:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658D51F22926
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 15:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B20A3CF72;
	Mon, 12 Feb 2024 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="gqZdSVPe";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="t1xYWnO9"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD03CF6C
	for <linux-can@vger.kernel.org>; Mon, 12 Feb 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753576; cv=pass; b=FuQvuPdcqkkV4eYvcR3Ilb2JfwdeguRz/CU6pHV/6AWKoPh1n2a2I8hVr8YL1PJ5phtXBfcKH/Qjrvu1j4Qdo4kIFvknG1MvlWLtv+98Yj+YXiHty4V97VownzC+Y9VGQY1fiA1d86bIOk7lDGx65/xLeitsJzamsH4c1bQi06U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753576; c=relaxed/simple;
	bh=uwCM4SKcCDLo13nM5KaVBWvJcMJFu8V+khSH87UjwFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVu3MryBZOBPLysUvMi7pF27TGCUfPtQWti5e7tP0h9Gefuev97wHCSX1PSeLy0ZkBu5xv2HXjUMRGnF1h9ZAKz7vejv3vpSuCelOP5AVSslvA2HfiCEtdHcrPdRmrxH+OtMZuuzzMhr0iceTND7gcx+S040CqtARgzS8fVSLEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=gqZdSVPe; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=t1xYWnO9; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1707751769; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pH5dWztPgaQipf+Jh7960H4QVgRKgIydBd/FOnMzjWwfEJFrGSI/GT6Nx0n73GbiWZ
    iaQTzaxGACvXv1WDGgTleGb6JSDcV227414Ghl0NEufS4pOtwVj2G6avjjNVUtMw8iTL
    c6PWK6qY5h1tgCu3tfre/8WxunXVEs7Z0Hg8TeL3INL38BRnBIy4pFMqmHkh2Ymr2uvq
    EAI8aPTDLBB4IIfIJBl0GBPP4xGLyBB2Qg3WsnS+tIg3Df/Zx+RGXJbuXlqobLMPpNxt
    +j5Zxc53ufOBfmHWTcNrCGMsPo+nJnU/tQPBahEW/w4qG3XoZd1+HGvNiYf9c4YDOy50
    qvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1707751769;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8Z6A1rW/hEP82xGWup3l1YbYom5466b1xZcQQaIBKuw=;
    b=EpUq1FH9ASI2VDAKP1FWCkZ4+OJJrQ/pnjToVG2z+CXan9bFTdSZJFFDMJ4yDxEj+G
    iNfISPzxGl52w8oB/wXD99saVdv8P+3WO+mhL2wkYmU2WtmQ4A/JwwES15v0Tvz0VobE
    nF8cqFJ+qSym8obqu4vsl//usnA0Xns7uXoUDyZptQRrqQnwLVhAu4RQ3HrRxM1iLuTi
    5vhgHm7lRrO8JmDeLbyZ2wcCAR8Y0LQ9dcsM0ahm6IlP15dTCnsFchrhwF4GLLctXsQX
    klv48+BnCnbnWQb6J4fU92IBBoIKv1H8St7mVaiaOHCdYL543je/1hu4j/gpuWo+CbvX
    MqOw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1707751769;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8Z6A1rW/hEP82xGWup3l1YbYom5466b1xZcQQaIBKuw=;
    b=gqZdSVPeGR7riVLcXi/4qTtLvq1bz7IAsI4CRB+J3S4704mqY7++ZN15tAOnY7QQIl
    kNog3VUBDW+XpJrvh2TRDPogpL29/08piCvGC4zK3TICxHKa8HL6tu+9/hJ2XDnoIryr
    XAkVGCCXJIKek4BiPjjC7bXPZSywANJMoR0vsmmt6yZUVc79VGjDPz9+5a/LUDux1J/W
    aq4x67vg7oXLOJeSA99m/yp1plivKnNxn6izPxPqazthIBzmF19MNdrBokZ7bPXdKgmu
    PGExn7hYYx864+tJgQi5IAR+qJIcE3KgL/J+P1gOA/nlXjuZ0JaY1PTY4uqfofrf+tXy
    DmcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1707751769;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8Z6A1rW/hEP82xGWup3l1YbYom5466b1xZcQQaIBKuw=;
    b=t1xYWnO9W4QjAcwoFrWy4aj4F0ihDkwFToORmMp6q+Dh2bv8dWPXJGT3QNwAWzHGr7
    dAuXaFGxkwEpqyI2LeBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0USEbHoO0g=="
Received: from [IPV6:2a00:6020:4a8e:5010::923]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01CFTSpes
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 12 Feb 2024 16:29:28 +0100 (CET)
Message-ID: <c5cd87f2-3cde-43d0-9cbf-e7d4de6b9afb@hartkopp.net>
Date: Mon, 12 Feb 2024 16:29:28 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rework v1] canxl: add virtual CAN network identifier
 support
Content-Language: en-US
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Guy Harris <gharris@sonic.net>,
 Vincent Mailhol <vincent.mailhol@gmail.com>
References: <20240212151404.60828-1-socketcan@hartkopp.net>
 <20240212-smooth-pregnancy-3c6ff0a86246-mkl@pengutronix.de>
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20240212-smooth-pregnancy-3c6ff0a86246-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> What does that mean for
> https://lore.kernel.org/all/20240128183758.68401-1-socketcan@hartkopp.net/

I've send another mail on this question. I just had to wait for the 
patch URL to show up on the ML archive. Did not expect such fast reply ;-)

Thanks,
Oliver

