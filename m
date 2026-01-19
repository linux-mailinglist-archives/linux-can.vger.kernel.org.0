Return-Path: <linux-can+bounces-6224-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2F0D39FBB
	for <lists+linux-can@lfdr.de>; Mon, 19 Jan 2026 08:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C7153002158
	for <lists+linux-can@lfdr.de>; Mon, 19 Jan 2026 07:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED802F0C78;
	Mon, 19 Jan 2026 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="AO8fZsm9"
X-Original-To: linux-can@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361212EFD95;
	Mon, 19 Jan 2026 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807641; cv=none; b=KwOxgXorrTJ5EtvrTBLUALMj4Z9OutlkMUYtMp48tu2XUk0b0zTzLau2NfD/yHSbCAZvZpWZR/C1L7S/2Of4nBJOPRLdB6RfynCiOFMdYN/ZF5LMBIdkRWR+ARoKYNvfTPpnt1+0DIR79Le2pir/geoXEC0y4MNLzXcBMqQLdUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807641; c=relaxed/simple;
	bh=QrvvK8DwqAX5G1g3b1UVXsJAicOUBLZ7e9IhSG1K0sk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h2G9wFWdALFhMJwWzUe5p3fp/d5e3/RHOVYfYRSRGvpHRD1wxiAS+ChcYxoSalKnE9Y8D/5ffOtQvWIoR4bwsSolarajs8EBeu5TeoPfkj6m7FVOfllh7/W573/xv6G9VHS2O9q4AgM/nvkvjir8+qLR3za9HgFstww0tyophSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=AO8fZsm9; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 3AA682295F;
	Mon, 19 Jan 2026 08:17:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1768807078;
	bh=QrvvK8DwqAX5G1g3b1UVXsJAicOUBLZ7e9IhSG1K0sk=; h=From:To:Subject;
	b=AO8fZsm9YwxxOGFjr1ytGLZwS6mHPH/ZMaN5CDqGdE0mtZ3W0NcUffjkCO4EfyOyO
	 Q40UYyDRJUIDjAry3ZxYdoCud0GxP/ufmqRFjlZdtJxOAUB62yXR3aHJVVUVdCZsHB
	 23uRSJwfXF82HLc3ns3l9J8jW+Vr4ljWnNWNxDnciXpiy8V7A1TUmhFXmb7DpBHTB6
	 r6XQWEkOhAKYbeCAAJP840sV9VDVNj/sLjp2HYnR382UnmnNsUrT9pqkeJhED8iEbZ
	 4nk6T32WUJHW43Zg5JL16IBRJLJzg/1Vnhk1VpmcRVeJeO9P1+qsif0tcSs75T8tix
	 Z652yd92WFdrQ==
Date: Mon, 19 Jan 2026 08:17:53 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 6.19.0-rc6 CAN regression
Message-ID: <20260119071753.GA14836@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
there is some issue with CAN on the latest linux 6.19 RC,
canfdtest fails with `send failed: Invalid argument` fails on various
SoC (NXP i.MX8MP, i.MX8QM, i.MX6 ... and TI AM62 and maybe more).

Is this known and already being addressed? I have seen some recent PR
and patches, but I am not sure they are fixing this issue.

Thanks,
Francesco


