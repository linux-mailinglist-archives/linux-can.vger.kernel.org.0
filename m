Return-Path: <linux-can+bounces-168-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA4F83F9E4
	for <lists+linux-can@lfdr.de>; Sun, 28 Jan 2024 21:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48153282805
	for <lists+linux-can@lfdr.de>; Sun, 28 Jan 2024 20:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4882E854;
	Sun, 28 Jan 2024 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZHMhE/jl";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pwWzWMW/"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD222E832
	for <linux-can@vger.kernel.org>; Sun, 28 Jan 2024 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706474557; cv=pass; b=pbkVDLEztBcj2NBItDaxYi3cVWr4jFBDAI9PDbPjP3J1PSB/vUHA5gkGB8FK0l90cMCTEA3JleifdBGa8m5yqirbu7IkORF0vSmVVB+L6IrpaqITFWHMHzlembBJJNa0vPMVLb+h1nHbQ30URqqq86CO0Lx3CZ+iip6jDEpKGmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706474557; c=relaxed/simple;
	bh=TpE95rj/TitS8jf1M5m25SfusrNcosNWEeRyMHnfrGw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=KhZM57g02yL9G8RUrikfvfs95k2GmCbGSdPGkqyKeaW4cqmDhOxMBVkfztmD7J/lwYwF8hDQrHsyj6AqNLnQvGyhp+OatawIaUaYplg3bYkz26bcCmBWWQLB7sFvUvBRTu7qxyG88lJhU/DwsdExNdKSASJbQOqT473puhJlWVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZHMhE/jl; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pwWzWMW/; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1706474188; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Cv0oNyeQhDU1JgNBScsmVEUqxWszcJOWSxWGY+kFDJktg8hfaSZ1SJZZN1ksR4ptCI
    TpdCrRnZm07xAYMARi+I3Z3vogbwM4I88KbodPfDdlDPpAKUx8ICudsJAzSohAvLOfYK
    j9QBxI1XyMt2sgFq5EEj0kRmPf4nScFd4TeUWFLmADf9TFaV/zgR/e1vZIKsznAvSONr
    mD8+ZWldqAn1cCGAD1QbI5DjxbW1CximDxHNOXibdyB/RNgz6zmxhkSN7dA/974UUiAs
    0OeSZnx4GCl0V0539fM9d7UCZGtGCpirgUlf6hpSNj+FNx1AhBRCyl/9C8Lt5TVJK6d0
    SyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1706474188;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:From:Cc:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=TpE95rj/TitS8jf1M5m25SfusrNcosNWEeRyMHnfrGw=;
    b=L5MsugzHz6/JYvEZykxWE1RoRkMxUnUzFOV0oad1lEY9Q92d/EQHpZXWV0Cfv1Gosy
    S7/7pF+qauyn7m4ulrGPSPU88Y120udUGIrwTZKpNxCtazR0tQHVDEWs0v63lPlVH/87
    k1dlYc8O4wyYhAkpFXkqRfGZZj2znc5ONVYIaf0NNzo06XCkf1EG0OKLuy5tkVrhAYMy
    fl+ukyXVi+5LFEYwhUiM2/Ub2Z5H7s/AnzuU+HmknEMRsAr57EEFEte/bgwVbAO7syEs
    X00f/SJsr1StWcxcSjb+ws/5dsFvySBWIpOKisrqV/uGK1crubh90i8QrDkxurqLSiob
    pGlg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1706474188;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Subject:From:Cc:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=TpE95rj/TitS8jf1M5m25SfusrNcosNWEeRyMHnfrGw=;
    b=ZHMhE/jlHxuQZp+cKlBljOBczD7A1vzbAXTUeg33P+IogxFuDSCdxcueAuXWrF5s9m
    dkLLozJzmPO88EQCi09YbQOozf2gMgG7Bh18vIAVBZHO0vUmdguOspJwmlizrZ54ClOZ
    QwEWIxaWxLx32LyS9Uo1Y+9ydKxBzMLm+n4TmQlHF5m5VIdoNQYYhSkukbPXCqnP8LZu
    uXgKCLZd3jgVHU8tpGUIW7Ne+7NBICZpomAFzCnhPJ9F3aZfrw3BFzpU34s/zFtoBjYX
    csLcXDFs/bwPqqRKGEbdgvOCg2hJEwF5P3peyzm9fs1g8UoNqK0AqHUPDjil/F8gwbNb
    BxVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1706474188;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Subject:From:Cc:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=TpE95rj/TitS8jf1M5m25SfusrNcosNWEeRyMHnfrGw=;
    b=pwWzWMW/rEeibJVD//ww//YyygxX21TlW9k4PawTk9brTg80x69suVg7w01oWXp82U
    us53X9WWvFLBfm3sMaAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDdAnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::90c]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c00SKaSAcc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 28 Jan 2024 21:36:28 +0100 (CET)
Message-ID: <21323546-0ea7-4506-a1aa-62f52452a8c6@hartkopp.net>
Date: Sun, 28 Jan 2024 21:36:21 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: can-next patches summary
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marc,

can you please consider to upstream these three patches?

[PATCH v5] canxl: add virtual CAN network identifier support
https://lore.kernel.org/linux-can/20240128183758.68401-1-socketcan@hartkopp.net/

[PATCH v3] can: bcm: add recvmsg flags for own, local and remote traffic
https://lore.kernel.org/linux-can/20240120081018.2319-1-socketcan@hartkopp.net/

[PATCH] can: isotp: support dynamic flow control parameters
https://lore.kernel.org/linux-can/20231208165729.3011-1-socketcan@hartkopp.net/

Many thanks,
Oliver

