Return-Path: <linux-can+bounces-5419-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE22AC60565
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 14:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6133935DE15
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5B9209F43;
	Sat, 15 Nov 2025 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjS8CUSD"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83E2EB10
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763211995; cv=none; b=Pclr1nmZlpqlql0sjSfsV7JAE4kI2DNL7SWm0TxqRvf2fEMfpxgdwVOxASuJgv4hM/iTywvhMPLRY2C9p7vx0fSangcw+ez5ofT/wDqggOW4YSOcqnguTAiCT2cBFAImWjzLcADH9b2EioAAS+QpRI2rN1Esp2JTlsGNug0+Qmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763211995; c=relaxed/simple;
	bh=qNp5BR6t+6JYkW/mM9k06B7Oi2fnj2JIsn3q9ZWskjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6CdSNoEjpyr5HZiIVr7WVZ3cNdh//Eh+VrEoc/fmdRbTiRC+2HvkoUePntTJ9lUk2pEbQRq96w9iVMwJOJ2ZSn463QSEpn0htAp8/TE8djvYvzfu1c3tI2/OYnOhwOoVEQgEQz3FyXsZ+e/nTY3udQJOip96HdX7I4saTsy0Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjS8CUSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17F1C4CEF8;
	Sat, 15 Nov 2025 13:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763211994;
	bh=qNp5BR6t+6JYkW/mM9k06B7Oi2fnj2JIsn3q9ZWskjQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sjS8CUSDQwa6bboHUSEJdkEy4IivrbswhUsGS9PnrR3xbiY4KnJlMtr/Tf+c2opqh
	 GLUX/EO3cIOXobsMJK0/bXJuakTHyI1iWSv/7YmnZeVEOIi8a1Ng+ewDo+F5hnO1Ds
	 5JBZg86wTmZbiEs//AtoqE+FAvavI2PrfYA93aCtv3oe6izTYLGoqeRA2oct6Ejrwd
	 kaZRteDZUfK+rQleSTVDFvWIxByWRvl/WJ1WRFfHFJUk9zcMa47xyvNGs2ru+TGs6t
	 tKgahO/y6onPOEbrnnseTDOBypWnhby9DeMXhZbwXihN+xNeeFvUS+Wybk+7rDpoS3
	 bG+fVwqscoNcA==
Message-ID: <67564299-c929-4eed-991c-90c311d6b90d@kernel.org>
Date: Sat, 15 Nov 2025 14:06:31 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC remove CAN_CTRLMODE_XL_ERR_SIGNAL
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
Cc: linux-can@vger.kernel.org
References: <84cb473f-be5b-464b-a5d9-10c6f643f145@hartkopp.net>
 <ee2ecbeb-eb88-45a5-b13d-0616383e0987@kernel.org>
 <13906d6a-34be-47ff-bedf-c25a2d755aba@hartkopp.net>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <13906d6a-34be-47ff-bedf-c25a2d755aba@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Oliver,

I was very confused by your message and I spent the week thinking about it. What
bothered me the most is that the standard and the X_CAN's 1.5.5.3 table just
contradicted each other.

And so, I did my best to investigate and find which one is incorrect. Reading
some other sections of the X_CAN datasheet gave me the answer.

On 11/11/2025 at 15:12, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> On 10.11.25 22:22, Vincent Mailhol wrote:
>> On 09/11/2025 at 22:07, Oliver Hartkopp wrote:
>>> I've been playing with the PEAK CAN XL bitrate tool again and it gave me a new
>>> idea:
>>>
>>> There were settings for different bitrates and the belonging/resulting flags for
>>> TMS and ES (error-signalling).
>>>
>>> Staring at the options we have only three options for the CAN XL support aka "xl
>>> on":
>>>
>>> 1. Providing CC/FD/XL bitrates => ES on, TMS off (mixed-mode)
>>>
>>> 2. Providing only CC/XL bitrates => ES off, TMS off (CANXL-only)
>>>
>>> 3. Providing only CC/XL bitrates => ES off, TMS on (CANXL-only)
>>
>> Why isn't
>>
>>    4. Providing only CC/XL bitrates => ES on, TMS off
>>
>> a valid option?
> 
> I had an off-list discussion with Stéphane and other PEAK System experts in June
> and the outcome was that CC/XL bitrates with ES on and TMS off is possible (only
> with the PEAK CAN XL IP core!) but will result in a nightmare for support teams.

I will start by challenging this assertion.

Looking at the X_CAN datasheet, I see:

  1.4.5.22.2 Classical CAN

  All Classical CAN TX messages are either accepted or rejected, see
  TX_FILTER_CTRL0.CC_CAN bit register. There is no other option for such
  Classical CAN protocol. The TX filter elements are only used
  for the CAN XL protocol.

  1.4.5.22.3 CAN FD

  All CAN FD messages are either accepted or rejected, see
  TX_FILTER_CTRL0.CAN_FD bit register. There is no other option for the CAN FD
  protocol. The TX filter elements are only used for the CAN XL
  protocol.

Did you try those?

> The CAN bus will crash if it receives a CAN FD frame.

I do not understand what you want to prove here. Isn't this the expected behaviour?
If you are in XL with error signaling off and receive a CAN FD frame, does it
crash the bus?

If you are in XL with TMS on and receive a CAN FD frame, does it crash the bus?

The same goes with Stéphane's observation. Where is the problem? Which
observation does not meet the expectations?

> This is basically the same with the Bosch X_CAN IP core where you need to enable
> CAN FD for performing the mixed-mode. What would you set as a FD bitrate there?
> There is no "nothing" to be set into the registers. You might set 2MBit/s as
> default but that might crash either when it doesn't fit.

Once you set the TX_FILTER_CTRL0.CAN_FD bit, all the CAN FD frames will be
discarded and the FD bitrate will never be used. What should you put in the
register? That is not my problem. If the X_CAN is well designed, it should be OK
to leave those to zero. If you still need to put some dummy values, complain to
the X_CAN team, not to me.

> Looking back in our older discussions with Stéphane I found this:
> 
> https://lore.kernel.org/linux-can/
> DBAPR10MB41879125DC7369359E4AB256D467A@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM/#t
> 
> Stéphane wrote:
> 
> ---
> 
> According to [3] lines 170-184, the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL flags
> are not mutually exclusive, so why introduce CAN_CTRLMODE_XL_ERR_SIGNAL [2] when
> the combinations of CAN_CTRLMODE_FD and CAN_CTRLMODE_XL would allow us to deduce
> this?
> 
> Indeed:
> 
> can_priv->ctrlmode & (CAN_CTRLMODE_FD|CAN_CTRLMODE_XL) ==
> 
> CAN_CTRLMODE_FD                    CANFD mode (n/a)
> CAN_CTRLMODE_XL|CAN_CTRLMODE_FD    mixed-CANXL => error_signaling=ON
> CAN_CTRLMODE_XL                    pure-CANXL => error_signaling=OFF
> 
> ---
> 
> With the CAN_CTRLMODE_XL (pure-CANXL) the ES is always off and the TMS becomes
> an option to be switched on (default off).
> 
> And the more I think about it, the more I would like to go for this solution.
> 
> This setup covers all Bosch use-case slides and Bosch CAN XL IP core
> documentations (e.g. with the 1.5.5.3 Operating Mode table).

You are referring to those slides, right?

https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/can_xl_1/20230717_can_xl_overview.pdf

I see in slide 16:

  Error Signaling: Software Configurable: ON/OFF

If you are just referring to the example use cases of slide 24, then no. You
should not be tunnel-visioned on a single slide when some other slide clearly
states differently.

And in which world does an *example* use case in a slide deck take precedence on
the ISO standard? I am sorry, but taking a random slide to disprove what the
standard requires is not a receivable argument.

> And we can omit the introduction of the CAN_CTRLMODE_XL_ERR_SIGNAL flag as this
> can be retrieved internally from CTRLMODE_XL and CAN_CTRLMODE_FD to be set into
> the controller registers.
> 
> Not defining the FD bitrate in the mixed-mode causes more harm (to the system
> and the CAN bus itself) than urging the user to define it. Even if he doesn't
> use CAN FD frames.

I also want to challenge this. You are claiming that the error signaling should
be an implicit value. What if someone requires error signaling because of some
safety requirements?

Here you are just silently turning off a safety feature. How is the end user
meant to see the connection between disabling CAN FD and error signaling? By
dropping the flag, we also loss the reporting. No more way to see in the netlink
interface if error signaling is on or off.

The more I think about it, the more I am getting convinced that silently turning
off a safety feature and hiding its value is nothing but a bad decision.

> In the (really unlikely) case that someone shows up with a valid use-case (like
> len8_dlc) and separately wants to fiddle with the ES flags, we might introduce
> such a flag later. But I bet this will not happen.
The reality is that the people on the linux-can are a small community and the
security/safety researcher is another small community. And the intersection of
those two communities is rather small.

Before joining the linux-can mailing list, I was well aware of the lack of the
len8_dlc and the TDC, and so were the people around me. But no one reported the
problem, mostly because none of us were familiar with open source communities
and we were all using some alternatives (proprietary drivers…)

Once I showed up and implemented those features, we saw people using those.

My point here is that taking the request on the linux-can mailing list is not a
good benchmark to measure if people use a feature or not. At least, this is what
occurred for the len8_dlc and the TDC and I see no reason for this to be
different here.

(...)

> Either CAN CC or CAN FD with ES=off are marked as an "invalid configuration" in
> the 1.5.5.3 Operating Mode table. And I'm pretty sure the CAN XL inventor's
> implementation of the CAN XL IP core is compliant with the standard here. Maybe
> the standard is unclear in this topic or left some details.

1.5.5.3 also shows that FDOE is on whenever XLOE is on (even if error signaling
is off or if TMS is on). Does it mean that you can always send FD frames? No.

That table can just not be used in isolation.

What is not clear here is the 1.5.5.3 Operating Mode table, not the standard.

> What is your interpretation of the standard here?

It is not an interpretation. The standard clearly require that error signaling
should be configurable.

> What do you think has to be supported beyond the features that Stéphane and I
> suggest?

FD off + XL on + error signaling on.

>> I see this a bit like the can_frame->len8_dlc thing. Should you use DLCs greater
>> than 8 in production code? Hell no! But I still want the implementation to give
>> me this option so that I can do my weird tests.
> 
> Ack. But so far I do not see such weird options. And introducing code into the
> kernel there is no user for and that's potentially only adding complexity in the
> API that might lead to misconfiguration is not well-received.

It seems to me that Stéphane is able to use it and that you should also be able
to by using TX_FILTER_CTRL0.CAN_FD. And I could also test it with my dummy-can
driver. That should be enough testing, right?


I made my mind here. It seems to me that you are tunneled-visioned on table
1.5.5.3 when the other sections of your datasheet clearly point out that you can
deactivate CAN FD using TX_FILTER_CTRL0.CAN_FD. If you just partially read your
datasheet to then jump to some conclusion, I would not feel confident to follow
this.

The process to publish an ISO standard is strict with many domain expert
involved. I do not think that any of us here is smarter that the combined
mindset of the ISO 11898 committee. I would need a stronger argument to convince
me that the ISO committee did a wrong design choice into making this error
signaling configurable.


Yours sincerely,
Vincent Mailhol


