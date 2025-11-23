Return-Path: <linux-can+bounces-5614-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3749EC7E142
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 14:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2955F4E1368
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 13:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA19821CC47;
	Sun, 23 Nov 2025 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tqZmft/I";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="V6M1twmT"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5A1096F
	for <linux-can@vger.kernel.org>; Sun, 23 Nov 2025 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763903831; cv=pass; b=IVm2r4GEpMjFa9bNIrS9IhbIKAuzLMl8rqX9KQpgKKOvHKf/PteyEwSRy0Af4EHtN++R1s4GxpvKhTM5bUXYaqC5sLJPhRs4eS7SaaRRl0+PKMnBNUbJptbIdtS+9KhycWYX6qR3Ms6DXxI/GJ9mia0jUNom2gaGKn4pF0XecuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763903831; c=relaxed/simple;
	bh=ImTYYqpSpXsBuOswFm7Pz1WYBA5HdVMMd2nm1hQnKq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEpE1yZBUovJ5tkG4WSKqPdKOS45RtncieRYmTkQwkddOhySwUdAK7LFIL9m6wP1MXIGjC5I7WcVLfdmhdB2GpKI8NVw8jX3S6iKBjEAh+t2JDVodCQHHeTE1v/xrbzRhGtL4rrzz2IqlaCgTg19mhOeSD60R5Bh+pxkMOA9PoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tqZmft/I; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=V6M1twmT; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763903643; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tcEWrcofT1BxxEM46KKB6vFw24J2hamJksIf9E86gP7jBvI2N6DyNfQ2sV8pEY427L
    EwMZpbWbNpyWG22xZXkm/d+U0EmnhpSeUaxca/me62612kbCeFe35AUSqJcEDKbXGfWs
    /v2AZt9RaAaoYBG4cUQrKBHWhppZGJXyqyBdPQ5b5zXuBna1M5hkF6H3ACHo6NUG6B7J
    FrC0fvybwjrTSR18sCQ3DE43Ib05sl6/bwWzFepFP2sWnOdyjL2/b7lQIBVPZy1xgRyo
    K/HmL3wBBDtRttXPYZaQ96q4sedhTn5kxDPuPdjlzodGVrIDsnvwOndghYLQpjAYM6GY
    pb+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763903643;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0RJ4vPJR46fWHU6GqZphWROJPd5LO4a7ejckjYhW43A=;
    b=SKitpUHriNUwNYTvjn+OXNi76ZH7UP4Udd8bkrM/FUClrUIKgEVU9hR6Xua9SJD0Lb
    phEMpNriP+iJ8YZzYYD1d0brAfX6/wpjNOR8hUorMkkeu0tXJKKlutcdpWG+yzjIuVdg
    AE7L9m5xdjGSsYMgmAMWzlGIGlmhJCldIgcQNLur6AJxJ9A94xE9IsdaSULrTMDe6aY2
    mayeE54N3c+zd4pq9b2EwS0eRYEwNNiphS4ptS+pJaq50bQNekFpYm0PpxJr6kHuRclG
    ZY+Lgu0GZ0WiaGz45m1CrRMc0e3MGKxh19OpZ4IIREQd6XfTqqglSWwKcvxiu3korBqJ
    b2CA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763903643;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0RJ4vPJR46fWHU6GqZphWROJPd5LO4a7ejckjYhW43A=;
    b=tqZmft/IaTaXOVYG46g3lkLXuauvN6t7sHQCYZB9W1NVkg705ROs3XT41lUHssqPLT
    QDmznq+qlXwqN/s0D0icFRQGli2BqNg9/80TPzOa/Ayb6rampsfsB1daA7yh/VujzBOs
    ei+/Zx4sO2haHRLtzt1H1mGfw6Q8EFp+GvbFAAPfJqTEjw2kKq4yOdj/lQHyA4EH1CyR
    Sy1TGzMNoBEhE9SKzfBlEiASjBnr3ayiTQBfCT1GOxiXAVgM5Tx/2VgTkPmLd/tuoWaD
    ITQiOHSzD+43bMKZbIFTfpyJBLVG7x9RBRgMgp3O99OcpxptxZiuuYatE6s8ZoX27yfu
    K4XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763903643;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0RJ4vPJR46fWHU6GqZphWROJPd5LO4a7ejckjYhW43A=;
    b=V6M1twmTqqWDmwcIuKbVuTD16Ct098Ah/r3CxqAVVKpwdQVfxz5Nchu8T8F0JbB5BM
    6BJsd1ttOAgor0k2m7CA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTRoMrpo2Pns16vpLmpxA3b1slG7I0aZONkW6smX3kvVXGLKH4aQ="
Received: from [IPV6:2003:d5:5708:3c00:3380:d761:962f:4fec]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ANDE3He3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 23 Nov 2025 14:14:03 +0100 (CET)
Message-ID: <41d895e6-1ef5-4658-910f-e1e5fe312702@hartkopp.net>
Date: Sun, 23 Nov 2025 14:13:56 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [canxl v6 05/17] can: netlink: add initial CAN XL support
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: linux-can@vger.kernel.org, mailhol@kernel.org
References: <20251122093602.1660-6-socketcan@hartkopp.net>
 <20251123065230.7869-1-rakuram.e96@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251123065230.7869-1-rakuram.e96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Rakuram,

thanks for your offer to test the CAN XL support!

On 23.11.25 07:52, Rakuram Eswaran wrote:
> On Sat, 22 Nov 2025 at 15:06, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>> From: Vincent Mailhol <mailhol@kernel.org>
>>
>> CAN XL uses bittiming parameters different from Classical CAN and CAN
>> FD. Thus, all the data bittiming parameters, including TDC, need to be
>> duplicated for CAN XL.
>>
>> Add the CAN XL netlink interface for all the features which are common
>> with CAN FD. Any new CAN XL specific features are added later on.
>>
>> The first time CAN XL is activated, the MTU is set by default to
>> CANXL_MAX_MTU. The user may then configure a custom MTU within the
>> CANXL_MIN_MTU to CANXL_MIN_MTU range, in which case, the custom MTU
>                      ^^^^^^^^
> Minor nit in this description. It has to be CANXL_MIN_MTU to CANXL_MAX_MTU range.

Definitely ;-D

Thanks for the feedback!

> 
>> value will be kept as long as CAN XL remains active.
>>
> 
> At the moment, I'm going through the mail series. I would like to apply
> patch series in a local branch and test with dummy module. For that
> purpose, if I apply this series on top of linux-mainline will it work?
> 
> If not, please share the base commit details to experiment locally.

The patch set applies on the net-next tree:

git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git

Alternatively you can also apply the patches to the current Linux 
mainline tree after you applied this patch here:

can: treewide: remove can_change_mtu()

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=f968a24cad3da72

Best regards,
Oliver

