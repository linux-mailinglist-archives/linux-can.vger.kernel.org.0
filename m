Return-Path: <linux-can+bounces-950-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61779927DF9
	for <lists+linux-can@lfdr.de>; Thu,  4 Jul 2024 21:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925951C22681
	for <lists+linux-can@lfdr.de>; Thu,  4 Jul 2024 19:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7B771B47;
	Thu,  4 Jul 2024 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZiK80hoa";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="TMheLiUH"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008AC7346E
	for <linux-can@vger.kernel.org>; Thu,  4 Jul 2024 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720122500; cv=pass; b=qYabYlbC+RhBhUEdxVzeOYxINyr8zcTBlh4SDnsEWUJR0Yq1nXBMMGNlmsJY+1ke1plqwtrfjQHhgwrpzvzuG++KNjP9LonVvqm/szxt5egPrG5/Bs1qGEL5kc5TKzY98qIVV6UoVCoFB0HJUwEAvw7LotNktEVxDiEFH7QGq34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720122500; c=relaxed/simple;
	bh=a/lhKZqeNoJ9QZAhOFnKpZLLDyLhRyTIA5ymQqWKKDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ir0X7ZyVld1X13TQh6TKNcCZCK9EzQnWyTogtbwH/Ov9QyINAQ/MvkG+ZEANGInfy8OPmpK3U0NXtuJVWblkjjcMLRhYH2hNFLQgvFgkJc6e7iIC+3d7osc5XO4zrxfRwrGj4SNZrZPgR2CIDyU79gVbucTmkHbHKBvI+pvvOQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZiK80hoa; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=TMheLiUH; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1720122485; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kCsXOqqpNqeexb/HGVronGW5tkpGh5zjmz29C0qbibzU0sOoqrnlRsl84ckAIqtdlc
    1+tN3/q3bU5l9RDVO28iAqFEBlRSIw1S2iVzUYuoDuPOnjyfqnsNhF52tRCPaWvVpyHb
    rKq66Sgenjspzw87FTi6rSYEFtFQLCIbhAODm2uSQaGzmsOAlbZqp84X/mEbugVTT2ZT
    jCP4AsetTKj4OnLzFDHxwnOnK/nf5AQOdmw7XvZAf0Kbg2sdBy4YFK4jKSkC3PcyIC0L
    od8C6kWI5u9XWku22i+LjD4OuZDFokHW2e0uSDk7PU8PIA5CNsVhVY4a5byv/0u5/WDu
    ovUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1720122485;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=hCbZnRD2fQ/1ty6a9lVdrq1fVJNjh+zDLNWFrAXbL2E=;
    b=PiGnDdVNdgPjuE8wXFPJPGJvOkuWWdi8SKSBO8i0ccVWPmUxZGbB9zjrMweoPKtOxe
    fzIHj6DA04GdkLsmVo7OV05jSjftVE3T7T3bedbq+/vJX0r7SOBQkJzqtqN/NAkS0jbK
    j+zDBkFbPziXo0DHLQiS4ZC15Xjx33VdIsx7XU2juzDgy79cH7+H2+hTgVRaej18kXsk
    e2NW5YJ0dWUlTODyPAiWVGMffrJvegu97hkvfDe6uOtNDQn0nDRSzcJmP1pDoVUqGZuD
    6PWMKMkldqtJkeOGgPttqNjEg77llbSjBobJEDH/tb13Qs4IR70nNvrqfTLZwcBszQAg
    8QFQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1720122485;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=hCbZnRD2fQ/1ty6a9lVdrq1fVJNjh+zDLNWFrAXbL2E=;
    b=ZiK80hoabTchu5l2a3ChapX7X6QlaUKEuEx8C+MTWXFWECry+rmFsp8gZdrgwrXfBA
    wQT1BaZjYU6U3ibl8sYWAnOyqhMweKVwzibz+7RYxafH28aB5CynlktvqS0G58Xu2b3g
    JF/iVXo6ubYUhtD9NR4SPm4slKtucAGggPnCYu1CdQnm8FmN/7JmwLUeVVszt67xk3cN
    G8LPy08QRVSDvskpgEwVcVT2kDBYqzT7UrBFv1owCGYrTcclSWSQoqIo5d5y3A74jZEH
    gcs76JoVAg6xApeehZ+CFmmXv1Y7gMwIgyiNnPrjSRUFcsUgTvAizr7kMRghy74wUkbe
    A0Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1720122485;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=hCbZnRD2fQ/1ty6a9lVdrq1fVJNjh+zDLNWFrAXbL2E=;
    b=TMheLiUHCx1K5yoP7fspbnSVyY68mFUND3CHKi9aY+mmJinJY94tZBkL6Yi4gsE1G1
    uDsEpSwNpNYiBFI/sDAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSXVT6pap5"
Received: from [192.168.60.115]
    by smtp.strato.de (RZmta 50.5.0 DYNA|AUTH)
    with ESMTPSA id K0664a064Jm50Vq
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 4 Jul 2024 21:48:05 +0200 (CEST)
Message-ID: <32535446-91d8-47ca-b7a3-556f91ec85e9@hartkopp.net>
Date: Thu, 4 Jul 2024 21:47:55 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Introducing new Kernel Module for CAN over IP Networks
To: Matthias Unterrainer <matthias.unterrainer@st.oth-regensburg.de>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
 Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>,
 "nils.weiss@dissecto.com" <nils.weiss@dissecto.com>
References: <77a04054acea40a886d371adbd8d25d1@st.oth-regensburg.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <77a04054acea40a886d371adbd8d25d1@st.oth-regensburg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matthias,

can you please add some documentation to the GitHub's README.md file, e.g.

- what is the plan (mainly your description below)
- how to build and load the module
- how to configure the IP/Port with 1 or 2 examples
- e.g. example how to create a CAN-over-UDP bridge between two IP hosts
- protocol description how the CAN frames are embedded into UDP/IP

It is hard to get all these necessary information which is needed to get 
behind your idea from the code.

Thanks and best regards,
Oliver

On 04.07.24 19:40, Matthias Unterrainer wrote:
> Hi Linux-CAN Community,
> 
> my name is Matthias and I recently developed a kernel module during my Bachelor's thesis that allows for transferring CAN frames over IP networks, similar to userland tools like socketcand [0] or cannelloni [1].
> 
> I wrote the thesis at dissecto GmbH [2], a german Startup that specializes in security diagnostics and analytics for embedded systems, primarily within the automotive industry.
> 
> The idea behind the project is that dissecto has developed a hardware device that can be connected to a CAN bus and acts as an ethernet gateway to the bus. It is capable of capturing the CAN traffic along with the corresponding timestamps and send this data via UDP or it can receive CAN frames via UDP as well and pass them on to the CAN bus.
> This allows for remote interaction with a CAN bus, as well as an accurate analyses of CAN traffic, as packets contain precise time stamps.
> 
> An architectural design decision was to develop it as kernel module because of lower latencies and high throughput.
> For example, my measurements show that the average time it takes a CAN frame to get processed by the module is just about 1/4 of the time it takes applications like socketcand or cannelloni.
> 
> We have published the module on GitHub [3], and would appreciate your feedback and thoughts.
> 
> If anyone is interested in this functionality for the same or similar use cases, please don't hesitate to contact us.
> 
> Best regards
> Matthias Unterrainer
> 
> 
> [0] https://github.com/linux-can/socketcand
> [1] https://github.com/mguentner/cannelloni
> [2] https://dissec.to
> [3] https://github.com/dissecto-GmbH/can2eth-kernel-module

