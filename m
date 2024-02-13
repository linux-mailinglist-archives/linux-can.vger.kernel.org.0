Return-Path: <linux-can+bounces-234-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2ED852CF9
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 10:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E30D2B26E70
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA7A22606;
	Tue, 13 Feb 2024 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="O6sn41hZ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="twySL3uP"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E052260B
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817530; cv=pass; b=LGskKzBvShqCRQlT3lMeyEEKnlwmnrVzXn9iCMtMQYOMYCHT+TRyfyAmQTYagWyy4MWC4wF0GfdsRBYM65tg7vlsvn6l9MuL/nM1HG+dLBlDq3FVNvfXNZgGhyYoSoWionwt35oebZ8zPd1f5rZxW13pxJYGo9igq49XV8cwkhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817530; c=relaxed/simple;
	bh=HaNM4j7OnvgZS027Anla4ic+Ilqtj6Cclv07aJiMP+Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TgCC7UPFRxdnc+hNmthlapPjAG+GtpvVx4SPCACHYWgcgi3nksf2w74dYH/pJEUfp9VT5ZDV48GQkoK+LmiLuUi1+Ji/WqIxgmd2qKn4v9H1YOdDDeoIt4H92D7uCAu6hLfCKdVVf0fQvdp5nPu7Qir2jn6v2GHNcdLUoQkbKj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=O6sn41hZ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=twySL3uP; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1707817524; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=E1EHQmQUyTKW/Kx/K7q6s0v9JZAl2C7mG15yGffx3RonjPXZYxays5qrALzYt5sy1R
    eCWcZxRCfF1+TTsihnc+ydBFV5R3qObliO86ClQiBubpJGo9BSV04oh19/i+YydyxBpR
    sNd/XdmRL8gwSer2w0oFpSbW5qwT2VctdF5WRAyh7oWRE/W1UoxYDDMhvPgMFSftGr4j
    bmWRGkzT+RjbckZUpIpaamATTBaQUO/GBYk//QepA2ClOQIkTB29gnOau2PTywWH5ggY
    T8g+0bqoKqBzMeX9VdpDZKRYlUm8C3ZO5kZej1/fe9abbunzBcC2/52Jf4UqUN2qNiIL
    URGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1707817524;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=S5K41Uip/xXWDAt+FGuj9G4UByYBQvwwPgD/oQHl/t0=;
    b=ocX1gx+D8reJQ1mteWUeAeYQy5OLyLRWcwj7xwN56DXU4ebyjz1n6Eu9JAO4z3Zoo5
    wwUM+g6rIFi2fqbMs3LTA7ZtKe0IUbgQlxn6dGgP/evPXrdzfcQOpiKm1brZWlieXtYo
    n+1TKkLItBol20zWXd3YdQvuFCwrgy7CgnSRw3cJ+wW6h9HWgw/KJf0eMIfkEJFlbBiP
    elLYbaIeXmx5OMCx/7AgcapRcT1b9Pkw8J9/lXjzLrR+j9VtiggrR9gq9mCn8sCkMABi
    Le5FrR4RUhhCTTei4VJ7plicOPURsuNuxgPvHG5hG7MtW/i4Wa01PVH7+v7gadXi09HE
    Tzuw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1707817524;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=S5K41Uip/xXWDAt+FGuj9G4UByYBQvwwPgD/oQHl/t0=;
    b=O6sn41hZD5wiAG4sv7yC78pax59xR+Ir++5g4w2fbc1J6c6T1F/YE9anfM7kWEuXKY
    EYFsT5Xbex0kVG+QlGkIgJtK+DzTxH13B+cRcutvbMapZGZ5wnf87jWYrm/7i0F/qi+3
    ULop//Nzh+8HauzGsIvDtq5tatWc68zV7XDllfWEL0FaTwwbzXlIEMgqb9oMq6Oh7haN
    wUM/Is3fQyPHn5azwhr7vJ2z9TJ7ZPJl4iSC0tovM3x853lbQ3QBjFvqoBv0XXXNYczA
    WP99kWHMEH/So2p0ZCdSr5MnqpsyFe/xoDctof2Pb+7AxLtV/yh6KTs8UO5w3V9Mk3nz
    voEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1707817524;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=S5K41Uip/xXWDAt+FGuj9G4UByYBQvwwPgD/oQHl/t0=;
    b=twySL3uPUmuRXSJzXID3ou692QzUuAoZZKx92xk2WnNXubaX++3YQZlyZia9ho1tpj
    Q7dEBVOOr5yCCqh8QgDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0USKMwcOWj4u7uw8xIRvyV5DfJD0tw=="
Received: from [IPV6:2a00:6020:4a8e:5010:4f80:462a:46fc:6ff3]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01D9jNrMT
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 13 Feb 2024 10:45:23 +0100 (CET)
Message-ID: <a390545b-62f7-424a-95d5-5b35aa538ecb@hartkopp.net>
Date: Tue, 13 Feb 2024 10:45:23 +0100
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
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Guy Harris <gharris@sonic.net>,
 Vincent Mailhol <vincent.mailhol@gmail.com>, linux-can@vger.kernel.org
References: <20240212151404.60828-1-socketcan@hartkopp.net>
 <4a3f3605-6a54-4ca0-9581-eff900e6b169@hartkopp.net>
 <20240212-curry-aspire-408b56e4ef6f-mkl@pengutronix.de>
 <81082bd5-069f-4686-aa6e-08744cf16ff4@hartkopp.net>
In-Reply-To: <81082bd5-069f-4686-aa6e-08744cf16ff4@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

On 2024-02-12 17:10, Oliver Hartkopp wrote:
> On 2024-02-12 16:53, Marc Kleine-Budde wrote:

>>>
>>> Feedback about the two suggestions is highly appreciated.
>>
>> Then I'll skip the virtual CAN network identifier support patches for
>> now.
> 
> I assume the discussion to be resolved within a day or two.

It is done.

Please pick this "rework v2" patch for can-next upstream:

https://lore.kernel.org/linux-can/20240212213550.18516-1-socketcan@hartkopp.net/

Many thanks,
Oliver

