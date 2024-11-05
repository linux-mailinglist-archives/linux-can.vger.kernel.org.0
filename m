Return-Path: <linux-can+bounces-1902-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F26F9BCD00
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 13:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E2CB213B1
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 12:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC9D1D54F7;
	Tue,  5 Nov 2024 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hyEAgJGR";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="wPwxfb5c"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A201D0B82
	for <linux-can@vger.kernel.org>; Tue,  5 Nov 2024 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730810917; cv=pass; b=dbY2MPDvxv0XWrj1imtIfEQ2RmOoiJXVHZBCReMmAJ2jIuNjQT1Wjs6PVVstb8Gx+2VrDXXSae4tDJ9TdNcf+BmcZtV07EUb+KRcSx+woPvTT4wJUJbJYlE4IHaQ7y8gvGSLspR6uRoOOOuBxz90oQ9hG4irOdPLF7qR9kYMM8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730810917; c=relaxed/simple;
	bh=imNZ1EKYHg4qaOFj6KEroeSsWEj0db7Ji6cpRLHh9VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEo/zpwMCxyUVOYWJkX89dAa8cOxoxBopxpYDU8Fzy1FP+gpy930Nv2VYB+mj36ywl+y+bMsmx3Vtig2wnwd8WMDB/02sUzBIunL+Z6bPqB4rO9edEouwpdYV0tb2OiLIvFKqi4AhM8LAVdvKCs7xnhKsiZ+OzMDHiF81FRIynQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hyEAgJGR; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=wPwxfb5c; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1730810192; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CWODnqMd3be0G0H2CIa6qxRyMggabkMRMnt1b01zpAKYee9U20hA8BvgFkpWCg303o
    CdptsL9SVCJ60KK3bR06UcuRnzw9LulQJnvYJzlFqzPCDq9UdQBnL5JmelJnp9Bet4n1
    i7rpmmaE/R/7c31m+SIgkIOzfCaJFDYFcRSbi4VidCTrNjLJC0nXGeja3RfzhZuX/16s
    IfKgkvk9ZOqtK4LlmFyKKXorHMCPuMu5OYGBnyC2WnDugfwbT/XEE72uPRmtHc2fCVKy
    1kgl4YXRDrP99Y2he5FQbgJ0cJe2vHX/yZ3Tnsl4fZ1tppJlE4nJvurvRwJlujB/+N9z
    dMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1730810192;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=SpVZyJGUfiI9+pBG8dZK9deB3uGc0ko6aKNzB008B4w=;
    b=iw9+W8n9kZLOalrTZVbwwYb5NXqseyXoT5pz5Ze+GTNmW8GRBqlabvZBKGsQCmZJep
    t9mW9NMo+wwxUIZcTjF+wIO3srPYx29JshcDpH/l9kmqGyhy+Gt6hIOiIF8HP8J8Xrsi
    9U/dFUs1FS2XAV4EPrSrAy9YnaagO7lY2su7Zlr+MLLxDarACmVFLWuDrQ/s8ZE2V5H/
    8lonzYvJ8ZyE/ufmzuiY8DnxDFle9HSA6fY3j00ud7/ah9NPpjgcUgqMeEseODdKTv+n
    XptkCiRCUaP3qkukyDuItzQ1AijnhJbjs6CAGVjjxsw9ou9uGGh9gLBAp8pTauHq3a8k
    PCpw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1730810192;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=SpVZyJGUfiI9+pBG8dZK9deB3uGc0ko6aKNzB008B4w=;
    b=hyEAgJGRDwQMTlkpA1om68w2h19YZMetiM03n6tk99+5xw5OxN8lLjsdxvu21YQVXa
    DoaXEDextkPanmx02NZrGcK4tkrImgVeuj+MDEM2UkBoCyTic/8DLmZlunlsoykFowoO
    G+UoyMW54adrzeU/DTa/kWa8hHzz8uWGPXyqieBKPjh/hC5htjRE6IwmQ3spZZi1KSm2
    dXfO2Wg7HQ6X6WN14lBSDvxufWvclYcTHgQAoSgXsUS0XHiHagCyzZg4Iabvjo3Hf0Nz
    akuS/LyUM9bSV/unxI9k7pgfsV/nE53FMPjohT9zFoK25lQ9YIa86+6U0VvyrspdF3ef
    raWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1730810192;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=SpVZyJGUfiI9+pBG8dZK9deB3uGc0ko6aKNzB008B4w=;
    b=wPwxfb5ctU3yaz7LLV5pRCJe5EWFeU+SFQnFf80UJ0MUVNiEfbDY895dflwp4PBTxL
    7IDbObO4vVxERhaFw6Dg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id K63ada0A5CaWnKM
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 5 Nov 2024 13:36:32 +0100 (CET)
Message-ID: <f621c8e9-bdb2-43f4-9445-5c5e82fb6d94@hartkopp.net>
Date: Tue, 5 Nov 2024 13:36:25 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing CAN-XL XL data bit timing
To: Robert Nawrath <mbro1689@gmail.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org
References: <CAEQ16vpxthctdrpv0kBKEZJA8VNYffjGGPBGBY93RmKDD49bAQ@mail.gmail.com>
 <CAMZ6Rq+9GO0-5BfauX73ReNTn2LzkZP04eGaybS6Vh+t3=Gmng@mail.gmail.com>
 <CAEQ16vokv=Xq+0T=6=e3UMooa_jJYCW-zXWSMKVrRPnM1HoZJg@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAEQ16vokv=Xq+0T=6=e3UMooa_jJYCW-zXWSMKVrRPnM1HoZJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Robert,

I've seen your interesting article in the CAN Newsletter:
https://can-newsletter.org/uploads/media/raw/9b65ce48915450ad8463848124762907.pdf

Did you join the iCC 2024 in Baden-Baden this year?

On 05.11.24 10:13, Robert Nawrath wrote:
> @Vincent, thank you for the answer. Are there any plans to add the CAN
> XL driver and the netlink interface for CAN XL?

The current state of my CAN XL driver for the DE1_SoC FPGA setup:

The board has an Ubuntu 22.04.4 LTS with the latest Linux mainline 
kernel. There are three Bosch XCANB IP cores on the FPGA and I'm using 
the Bosch glue code which was provided to access the CAN XL controllers 
via /dev/mem (!) in a polling(!) access as user root.

I moved the glue code into kernel space to be able to create a real CAN 
network interface driver and added some hrtimer code to poll the 
registers as I wasn't able to make the hardware interrupt working.
I assume the interrupt routing was never implemented/tested between the 
FPGA and the ARM cores ¯\_(ツ)_/¯

The settings of the bittimming registers for CC/FD/XL are currently 
hard-coded following some CAN-CiA recommendations for integration tests, 
e.g. plug-fests.

I will restart my work very soon to upgrade the Kernel to the latest 
6.12-rc version and I will remove the Bosch glue code, so that I can 
push my frankenstein out-of-tree code to GitHub for further discussions. 
I doubt my driver will ever reach the mainline kernel, as the XCANB IP 
core is not intended to become a real Bosch product IIRC.

But it is a simple core for testing and building netlink APIs.

I will take a closer look - but the netlink bittiming just seems to be a 
third setting for CAN XL and whether the CAN XL transceiver is switched 
to the CAN XL physical layer in the fast mode via PWM.

I assume there are similar configurations for your DCAN XL IP core?

Best regards,
Oliver


> 
> I use the DCAN XL implemented in FPGA. I work for Digital Core Design
> and it's one of our latest IP cores. I know the CAN-XL controller is a
> rare product for now.
> 
> Best regards,
> 
> Robert Nawrath
> 
> 
> On Fri, Nov 1, 2024 at 3:27 PM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
>>
>> +cc: Oliver
>>
>> On Thu. 31 Oct. 2024 at 20:55, Robert Nawrath <mbro1689@gmail.com> wrote:
>>> Hi,
>>> I'm working on a kernel module for CAN-XL device. I can see in
>>> /linux/can/dev.h that there are structures and methods for setting
>>> bittiming and data_bittiming. The bittiming refers to CAN nominal bit
>>> time, data_bittiming refers to CAN data bit time (using ISO/FDIS
>>> 11898-1:2024 nomenclature). But in CAN-XL the data bit rate has two
>>> values: FD data bit rate and XL data bit rate. This values are
>>> different and the device shall have separate configuration register
>>> sets for them. So for separate configuration registers there shall be
>>> separate methods and structs.
>>> Am I right that the current implementation in kernel is incomplete? Or
>>> am I missing something?
>>
>> Yes, you are right. There is not yet a netlink interface for CAN XL,
>> mostly because there is not yet a CAN XL driver in linux-can and
>> because, before you, no one manifested a need for this.
>>
>> @Oliver, in this message:
>>
>>    https://lore.kernel.org/linux-can/2540406e-8da3-4cb8-bd1a-30271dd6cc67@hartkopp.net/
>>
>> you mentioned that you were working on the bitrate configuration. Any
>> update? Seems that this is time to make this live! I did some work on
>> the netlink and the iproute2 tool in the past when I added the TDC, so
>> eventually, I can help a bit if needed.
>>
>> @Robert, out of curiosity, what is the name of your CAN XL device?
>>
>>
>> Yours sincerely,
>> Vincent Mailhol
>>
>> Le jeu. 31 oct. 2024 à 20:55, Robert Nawrath <mbro1689@gmail.com> a écrit :
>>>
>>> Hi,
>>> I'm working on a kernel module for CAN-XL device. I can see in
>>> /linux/can/dev.h that there are structures and methods for setting
>>> bittiming and data_bittiming. The bittiming refers to CAN nominal bit
>>> time, data_bittiming refers to CAN data bit time (using ISO/FDIS
>>> 11898-1:2024 nomenclature). But in CAN-XL the data bit rate has two
>>> values: FD data bit rate and XL data bit rate. This values are
>>> different and the device shall have separate configuration register
>>> sets for them. So for separate configuration registers there shall be
>>> separate methods and structs.
>>> Am I right that the current implementation in kernel is incomplete? Or
>>> am I missing something?
>>> Robert
>>>


