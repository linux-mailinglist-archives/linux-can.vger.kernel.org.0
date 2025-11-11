Return-Path: <linux-can+bounces-5334-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFC4C4E7B1
	for <lists+linux-can@lfdr.de>; Tue, 11 Nov 2025 15:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900FE1896177
	for <lists+linux-can@lfdr.de>; Tue, 11 Nov 2025 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81AF2D9ECB;
	Tue, 11 Nov 2025 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iO68JQGx";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="499emmIJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2828A2C324C
	for <linux-can@vger.kernel.org>; Tue, 11 Nov 2025 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871111; cv=pass; b=me3XL73zXOsTPIaQNTNXyqEN7agP8xDUzsGkpYonBsEQYP5DeXM6CTrO/NlxXw9410wYC+0Lbm97RAFXwK3QOkPktzvcTlVtyVAK1S1uizKnoiJw2DAcK9dsEdWARhsuD3k6t88NCguf1IonOq9l+IFX+QgOxiM5dhr0gpOFS+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871111; c=relaxed/simple;
	bh=kCxFGyASr08JblHFx8Ys69FWZQDL38mi2AcB0DzTiXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Ka3NkaFTIRDlmr+FTBqKN3E7reWfRqFz/Vcz/qTXjRL4zRt1OXu222Zo01sleVm9TYueS6y6hpmF5f9yXvZFK1DhcZt7THyfWZr/0+6Pc+cgwAlcySW3RF1StH0p5fD5SheMazmsR+v5i+ElEf/55V0rt91rs/hr+jNeSHlwXYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iO68JQGx; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=499emmIJ; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1762870383; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TlDHvV0WzHbtawQsMvVpq2n8U8XbfE7NxIQNGeYVZR9bCfgG6o0AUrWnSxEcrl9D65
    1uGUM55YplD/zzpDNEdOXOqDym5hhgWNyGBVdioFMJMSyGNQBe+Odxn64hIAU9N572w8
    Jvp5avR6LQFI8g2JZOF2QjhL2+bs24daoWWIXPZnSNrJ8U8nz3zHvrB4NPix/G/SOLot
    SlAZRuNwhMKZ+ZJvk9/MZrDA+V/rZk0m3bzZc6ZvAmAK3We6sBM3RwGZT436y6LwACmi
    Rxes6HWkQ4GETiuQscvympPelkw2E3qfJZqyiwsKmG+Y80NZAf46ouordmgucM70nV3w
    y/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762870383;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lixbYX8hMbzdgJm2KrXi4CM7cJT6q9W5Cl7mTbqmG14=;
    b=Gwom2cu8N7DhZB4iv/VGcQR69GxEE4aSgDQa4AJcjlYKTGByOqUggCHTzsQKzn3WiY
    K70GAjlZaOKPCuxiOo2Rh5qMMxw+FMlEaQjZ83yHEEUeE1A858fkXdKlnr6d60ZDyTb7
    ofyoqdrp28SgyTZ+BNV9qJmN7s/tF8TITNnB/U5Ko/P9rmx5DWLw/SYZ2zqB4aqR56nI
    DuHjjR2/rtjvPEUYJpxCReSiJ98MfcbIv4qRW7GW59Ti6/SAalF8NnTfEEixfkNZQvKi
    lqBZ5DeozSrkzjjnDi+q1Itch4YZ7Zsw47UJIkE4YF9ByxS0b9wFJ82Ivd9oYtAReNCy
    r6QQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762870383;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lixbYX8hMbzdgJm2KrXi4CM7cJT6q9W5Cl7mTbqmG14=;
    b=iO68JQGxyTQgASlOtMdxPlRoMO6Yo2VYGrhgrzTJJ/btpmc71uBYElh3+BAhYxURid
    CPSuHoLp1dfVJc7Im6vOQdoqZdVAV/X4XxdYwYhwef8GKzte/+H/C76ipyFtCqwM6DXc
    GOs4tv+3jzno6x+EyuhFUVtqzoMATUmaPDXTe3AJD8foSDrBiAP0xZZLa3ewhRug96Il
    yGjrkYaCV8E0YIM6pOTICm8fHhO71Lobz32qZU7Zu5KXthpJke9SsBLZD7nP+CN6bBAk
    4DSQlGnIzFnV5zzxq1bnu9348eH6feypT8d7UWz+TZqkoWm1+tZ8JleHwf3YL6Cs5Mx3
    5QgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1762870383;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lixbYX8hMbzdgJm2KrXi4CM7cJT6q9W5Cl7mTbqmG14=;
    b=499emmIJKx5F4J+Xyw4R0XOzr+CdZrPHVx/kzkvR7bPm+HbbEqBlYE7LrIO3MR4Cyq
    lYl8b8+LsEMpf//pErBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ABED2Orx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 11 Nov 2025 15:13:02 +0100 (CET)
Message-ID: <13906d6a-34be-47ff-bedf-c25a2d755aba@hartkopp.net>
Date: Tue, 11 Nov 2025 15:12:56 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC remove CAN_CTRLMODE_XL_ERR_SIGNAL
To: Vincent Mailhol <mailhol@kernel.org>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
References: <84cb473f-be5b-464b-a5d9-10c6f643f145@hartkopp.net>
 <ee2ecbeb-eb88-45a5-b13d-0616383e0987@kernel.org>
Content-Language: en-US
Cc: linux-can@vger.kernel.org
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <ee2ecbeb-eb88-45a5-b13d-0616383e0987@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

On 10.11.25 22:22, Vincent Mailhol wrote:
> On 09/11/2025 at 22:07, Oliver Hartkopp wrote:
>> I've been playing with the PEAK CAN XL bitrate tool again and it gave me a new
>> idea:
>>
>> There were settings for different bitrates and the belonging/resulting flags for
>> TMS and ES (error-signalling).
>>
>> Staring at the options we have only three options for the CAN XL support aka "xl
>> on":
>>
>> 1. Providing CC/FD/XL bitrates => ES on, TMS off (mixed-mode)
>>
>> 2. Providing only CC/XL bitrates => ES off, TMS off (CANXL-only)
>>
>> 3. Providing only CC/XL bitrates => ES off, TMS on (CANXL-only)
> 
> Why isn't
> 
>    4. Providing only CC/XL bitrates => ES on, TMS off
> 
> a valid option?

I had an off-list discussion with Stéphane and other PEAK System experts 
in June and the outcome was that CC/XL bitrates with ES on and TMS off 
is possible (only with the PEAK CAN XL IP core!) but will result in a 
nightmare for support teams.

The CAN bus will crash if it receives a CAN FD frame.

This is basically the same with the Bosch X_CAN IP core where you need 
to enable CAN FD for performing the mixed-mode. What would you set as a 
FD bitrate there? There is no "nothing" to be set into the registers. 
You might set 2MBit/s as default but that might crash either when it 
doesn't fit.

Looking back in our older discussions with Stéphane I found this:

https://lore.kernel.org/linux-can/DBAPR10MB41879125DC7369359E4AB256D467A@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM/#t

Stéphane wrote:

---

According to [3] lines 170-184, the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL 
flags are not mutually exclusive, so why introduce 
CAN_CTRLMODE_XL_ERR_SIGNAL [2] when the combinations of CAN_CTRLMODE_FD 
and CAN_CTRLMODE_XL would allow us to deduce this?

Indeed:

can_priv->ctrlmode & (CAN_CTRLMODE_FD|CAN_CTRLMODE_XL) ==

CAN_CTRLMODE_FD                    CANFD mode (n/a)
CAN_CTRLMODE_XL|CAN_CTRLMODE_FD    mixed-CANXL => error_signaling=ON
CAN_CTRLMODE_XL                    pure-CANXL => error_signaling=OFF

---

With the CAN_CTRLMODE_XL (pure-CANXL) the ES is always off and the TMS 
becomes an option to be switched on (default off).

And the more I think about it, the more I would like to go for this 
solution.

This setup covers all Bosch use-case slides and Bosch CAN XL IP core 
documentations (e.g. with the 1.5.5.3 Operating Mode table).

And we can omit the introduction of the CAN_CTRLMODE_XL_ERR_SIGNAL flag 
as this can be retrieved internally from CTRLMODE_XL and CAN_CTRLMODE_FD 
to be set into the controller registers.

Not defining the FD bitrate in the mixed-mode causes more harm (to the 
system and the CAN bus itself) than urging the user to define it. Even 
if he doesn't use CAN FD frames.

In the (really unlikely) case that someone shows up with a valid 
use-case (like len8_dlc) and separately wants to fiddle with the ES 
flags, we might introduce such a flag later. But I bet this will not happen.

>> Therefore we only need "tms" as an additional option when xl is on.
>>
>> The error signalling "on" automatically results from the availability of "fd on"
>> and the FD bitrate.
>>
>> Examples:
>>
>> 1. Providing CC/FD/XL bitrates => ES on, TMS off
>>
>> ip link set can0 type can bitrate 500000 fd on dbitrate 2000000 xl on xbitrate
>> 4000000
>>
>> 2. Providing only CC/XL bitrates => ES off, TMS off
>>
>> ip link set can0 type can bitrate 500000 xl on xbitrate 4000000
>>
>> 3. Providing only CC/XL bitrates => ES off, TMS on
>>
>> ip link set can0 type can bitrate 500000 xl on xbitrate 10000000 tms on
>>
>> That's simple and provides only the needed switches, which makes
>> CAN_CTRLMODE_XL_ERR_SIGNAL obsolete in the netlink API.
>>
>> What do you think about this approach?
> 
> What really bothers me here is that the ISO standard explicitly state that error
> signaling is a configurable option. Making this an implicit option would result
> in a somehow non-compliant implementation.

Yes. According to all the Bosch slides ES=on results in mixed-mode and 
ES=off results in CANXL-only. You need this bit to distinguish these two 
operation modes when using CAN XL (mixed or pure).

The fact that we need an arbitration bitrate for the CANXL-only modes 
does not imply we can send or receive CC frames (with ES off).

> I appreciate that for most of the use cases the error signaling can be inferred
> from the other values, and this is what I tried to implement (c.f. the table of
> default values which I put in my patch).
> 
> But I want to leave room so that people who wants to push the standard to its
> limits can.

Either CAN CC or CAN FD with ES=off are marked as an "invalid 
configuration" in the 1.5.5.3 Operating Mode table. And I'm pretty sure 
the CAN XL inventor's implementation of the CAN XL IP core is compliant 
with the standard here. Maybe the standard is unclear in this topic or 
left some details.

What is your interpretation of the standard here?
What do you think has to be supported beyond the features that Stéphane 
and I suggest?

> I see this a bit like the can_frame->len8_dlc thing. Should you use DLCs greater
> than 8 in production code? Hell no! But I still want the implementation to give
> me this option so that I can do my weird tests.

Ack. But so far I do not see such weird options. And introducing code 
into the kernel there is no user for and that's potentially only adding 
complexity in the API that might lead to misconfiguration is not 
well-received.

Best regards,
Oliver


