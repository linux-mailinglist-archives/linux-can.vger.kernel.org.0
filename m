Return-Path: <linux-can+bounces-220-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DA884FEC5
	for <lists+linux-can@lfdr.de>; Fri,  9 Feb 2024 22:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B0C1F24510
	for <lists+linux-can@lfdr.de>; Fri,  9 Feb 2024 21:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9714017BD3;
	Fri,  9 Feb 2024 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UGt/T2PU";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="VtfA2zF7"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9659B168A3
	for <linux-can@vger.kernel.org>; Fri,  9 Feb 2024 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513954; cv=pass; b=My+IcVl1eCpCMXOjDGfugMKJio8cmo4rhzm0vm/G+o00kM0pDGw1vc//mDkzCijnkCEqlxaH8DrZWin7LY5COzw6gnHdlNWfrxW+6gI7pN2GhfMaeKyXDVkTpTnkp8Q0ON7HfgVkFCT/m3EpF9Ic22B5tSZ33ozUE0jIIr/MUy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513954; c=relaxed/simple;
	bh=w0IZ4+qchJYuBI1C+GwADDLo7gpmB9f4z772LozsLEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R8IoSZwpXMBu005O1ml9Ge4pwm9yqVKu9ZtA+RQ1OPKFxve1+qqjSL3RkV0YdgNb1ENXbbrunYP7uU4xBDoPne+WQnXER85KUqmmBysYGV9MyTQg+JTkBJSbHvWikD2J+x8bFbkJdAqxhXIdhvsXeLULBODziu9BNdHJK8yQZHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UGt/T2PU; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=VtfA2zF7; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1707513943; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KAR4p/2GaF4B4Pon/0rmpJi5NwqPrdgTMOdGHl45UgZhaUp5salB95bnV0DaaPYRuc
    qD6eGtn8jpntBME85RRPlJtwCpLV8P187nHHqfp76mXZdd7SOfK7EjIs8kojB0osiLI1
    BRTMG//Aycl3KNNoc7gH+MecWrBc1eVpTBrWSKQ9kX13gn8gOgD53zfrteNRfJGN/IQT
    V5VADYqW7pEjxvfnIRkb9BCxPA4k9FpWHtglbESgi5IAlPv2LpaoYEk6RvEpcR9zQaRh
    fsmCBCOQ52MvuIvMO1gDsFx5cqudqoyDqvqB46ZFQLNlW7pxTgWmtu1O7Qi/euVy3Eu2
    GCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1707513942;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=F0l1vSIcEFyZ3ouy9cjYSsfJIhaLkdkYRVvnCR9Gd9Q=;
    b=cG4ELgrHPFWkX9zX8oMW2tap5mzBuQc9Us71k8+CVoLGcZi0vaQvlWAy6U1wH6Rygo
    BO3WRYRkWPkbFsvkevnnKv+AywL5bNy18qdlRe9mU+AsXlOnwxQCD8FKS92Ig+muWkWE
    yAeoFSmX6uU20DiT4nTAD9klvVbj99o5l8BrJHskWuTpTNPQUm4JoGU33VMzWuTm+yJL
    Er/rzw3Xa9aHHm11nOuC0CHJnWqECNMkxjT8o3K9FubpPvx84SKd0vDrOKkUA0xp1njG
    FWnlsmEesYArmaBCEK3CkDOFIg9n31R9HzsxWm71KT5FAUIyQkjpr9XCO3ePpDZMtHzf
    deuw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1707513942;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=F0l1vSIcEFyZ3ouy9cjYSsfJIhaLkdkYRVvnCR9Gd9Q=;
    b=UGt/T2PUl5NW8FdbPqU2JAMkJa4wQj3ZzQRLVAJUjD2/+TBdFfv30dDKRui6Pr4kWF
    HMS//cV9j41MWRDBVd2B2qF6UzjC4OPeYqCjgyVZ2OCMumimFbDM9AzUllK36s75kuut
    02tNeKNY48lyrSSc6vWVaP31pwb5b2dylz3Wkg6ouXpK28SDtwIF2X/5nK/6HILXsRAO
    vq0n9LAgyVLreuynQf1adCGrWKb3I6uhU1SEUC7RZmNCReBRdW6NWRtlE5+hreRvBgca
    FQjq2aV2UP5op3m/Ks0+FtRguMw8b4c6z5Con0jMDtv6WJYwzfgk3GXWXJU+e2F43H/4
    TtYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1707513942;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=F0l1vSIcEFyZ3ouy9cjYSsfJIhaLkdkYRVvnCR9Gd9Q=;
    b=VtfA2zF7ryI8k5CX8lfBmQ/eZJNYMvY/s0EYdSp0jwkPgtw6IzRDEKqNPLJ6jJZJT/
    Vg3j7jJZFt8PaTZpwTBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0UTcNM/uBqAvRIc5TRGszsnoG9c84A=="
Received: from [IPV6:2a00:6020:4a8e:5010:ba55:f47d:9668:fdfe]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c019LPglOn
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 9 Feb 2024 22:25:42 +0100 (CET)
Message-ID: <465e5c3d-fe8a-4b01-99b4-c955f0bcaa15@hartkopp.net>
Date: Fri, 9 Feb 2024 22:25:37 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Protocol recommendation for CAN(FD)-USB adapter
To: "Dr. Michael 'Mickey' Lauer" <mickey@vanille.de>,
 linux-can@vger.kernel.org
References: <0671FD01-F7C3-41C0-BD66-9E67150AB2C9@vanille.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <0671FD01-F7C3-41C0-BD66-9E67150AB2C9@vanille.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Michael,

On 2024-02-09 18:28, Dr. Michael 'Mickey' Lauer wrote:
> My team and I have designed and developed
> a new CAN(FD) adapter based on ESP32S3 and MCP2518fd
> primarily aimed at ECU firmware reprogramming,
> but eventually also for the use as OBD2-adapter,
> CAN-logger, etc.
> 
> The next incarnation will also have a
> USB interface and I’m planning the necessary
> changes for its firmware.
> 
> I would like it to be compatible with SocketCAN
> out of the box — optimally without writing a
> Linux driver, but rather reusing an existing one.
> 
> Which of the mainline SocketCAN drivers would you recommend
> basing my USB protocol on? From a quick glance,
> I’m leaning towards GS-USB, since this already
> supports different hardware families.

Yes. I would also recommend the gsusb driver and the CandleLight 
firmware project on the other side:

https://github.com/candle-usb/candleLight_fw

... where currently the CAN FD support is in the testing phase IIRC.

Both the CAN(FD) adapter firmware and also the Linux kernel driver is 
actively developed by Marc Kleine-Budde and others.

Best regards,
Oliver

