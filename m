Return-Path: <linux-can+bounces-5421-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C4BC60660
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 14:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9675B4E15E9
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 13:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFFE28AB0B;
	Sat, 15 Nov 2025 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UNSu6u+9";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="weJ+oUNg"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AA92222B6
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763214761; cv=pass; b=qvK21spE/DU+WM3ROxY8hdxtemUMxv3eQ7roFULQ0WUaQwpRLr4Nr08HWfWo+vTsijAEXBCbMwGzfvus0iQsAckuUtajA72fd3bt66DLVYb/Jn+qyePYki0sdtwUZwkEaFvCeKPVmUd+qqSiU0UH2JXmg76yR0EsZmFMsJLeTts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763214761; c=relaxed/simple;
	bh=ikLYCUEy5POuDI9RdT33Hum3GoE3SnQF9kGZCsrx9Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqjsPSDfLNt+wejty2lVWmZ/ZjGQU1Oa7oCnxSpBqCXwWFxPYZgiCk8vvY2233PiJY8EjcNwFEkbKaa7dARL5HRwQGRSSXoEg+5Vj1vAWhNBkSq0VZ9WhLxsBlwFeEL8WL2JedwboPYyIEjZXNO4uBky9zQf6XmJivgOP8Pc0SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UNSu6u+9; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=weJ+oUNg; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763214756; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Wxe5g2g4epbfnJplHZ/29BqBFw4uywLnMhaCQ5+NrVObrQLlANUd3e2OwR7Sjnocv9
    jLGjRDuM52OUxk4vCiX+B+sTT7+4dBtzSecMSwAMe4/T5lWuq0AmPEdRLEBVLqI6Wb8i
    oik+ht9ltj4XCjKJyIu2GfZRxPoJh1RzuTND+/cevBhvqIr99ErDEhR3c3npI5W2Nw42
    IhSAIHhFLRxI7jgjrs16H/uoeLsWBpncA5Ul/TxD1qKt5wU7ZYqz3mCluQVXhSViR5iF
    mSc83VcOfkTuCFZIHMT/PFxZn5jPC/jtAVdKSQG/DlvY4/qnS/6JskIuI9SoUDzXnYQg
    umkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763214756;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=orzsR24lW5ynK1LrlWqCYRzXAxKhPPKurHJsDUfWtMI=;
    b=gV0AgUymdJ7mIAkTpcObj4qvACq091r0GqP5emDKa1PPTxGkGJjW9oxsCcZ72/nrZO
    E2yZ/Tzm+1uYijOGQjBnIx59XcKPuF3aqJfMwANCwC3pM0w2rNvy9V3J7hV0ay5riLhW
    ewEk+BduTyEEqdh+iGPvusCn8I4n1TSACeqrWTrp0cj5FrpjZR37VMEKtTPwfud2QU+J
    7Xh2hOKuGg1De16cWEilAP7tYafnI6x0aYYF/M94XvG13pDgonXq3YKiDWmiJTH+C0yn
    4TAgVpQWgWyuZwXIAlWG/p2Qy7bunWotserND+XxNKNeFO01NnK82ReZtKgbNkXl/Ro8
    ODVQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763214756;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=orzsR24lW5ynK1LrlWqCYRzXAxKhPPKurHJsDUfWtMI=;
    b=UNSu6u+9HbrtWNp8LxoLVut6GQML6TB4GbGlEzDQfn3GSBjJARlhzyNtYL8y2gVxSo
    Cbm0T167uKld59shTdqt+jdTMBGmfPkbwQU0mFzwJGvlaVSX33rHcEosmedVUUcGFA+m
    2HBqgur2pgLOMv+5biThaAPAvoX0JJ2eouw94OlCWb2NvQEJ+KYYUZKxKZh/Iuq06Ec6
    tVQ4tfJTNEMM8M32UEvJMhJL/J4yCE3gRqfVUFeJxVMGp0xW9exzeGg7jnzUZOzPCAQ+
    yV2/MFYeqe/mqMY5q9SRVcoB2y94WukZRk0O8cnQmYFGT28AnbjYcqo2mCsG4tHr2COD
    SdHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763214756;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=orzsR24lW5ynK1LrlWqCYRzXAxKhPPKurHJsDUfWtMI=;
    b=weJ+oUNgBWffa/QWW1XSP8a1XnwD/gcRLDetmqUc8jdqsV2adDlZptIuHHSLKLp1Lg
    HN8jbZ6JKL5r7vPgR2Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFDqZdnc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 14:52:35 +0100 (CET)
Message-ID: <61f731ac-3876-45e8-a5dc-6cfa24f2739d@hartkopp.net>
Date: Sat, 15 Nov 2025 14:52:30 +0100
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
Cc: linux-can@vger.kernel.org
References: <84cb473f-be5b-464b-a5d9-10c6f643f145@hartkopp.net>
 <ee2ecbeb-eb88-45a5-b13d-0616383e0987@kernel.org>
 <13906d6a-34be-47ff-bedf-c25a2d755aba@hartkopp.net>
 <67564299-c929-4eed-991c-90c311d6b90d@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <67564299-c929-4eed-991c-90c311d6b90d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

On 15.11.25 14:06, Vincent Mailhol wrote:
> Hi Oliver,
> 
> I was very confused by your message and I spent the week thinking about it. What
> bothered me the most is that the standard and the X_CAN's 1.5.5.3 table just
> contradicted each other.
> 
> And so, I did my best to investigate and find which one is incorrect. Reading
> some other sections of the X_CAN datasheet gave me the answer.
> 
> On 11/11/2025 at 15:12, Oliver Hartkopp wrote:
>> Hi Vincent,
>>
>> On 10.11.25 22:22, Vincent Mailhol wrote:
>>> On 09/11/2025 at 22:07, Oliver Hartkopp wrote:
>>>> I've been playing with the PEAK CAN XL bitrate tool again and it gave me a new
>>>> idea:
>>>>
>>>> There were settings for different bitrates and the belonging/resulting flags for
>>>> TMS and ES (error-signalling).
>>>>
>>>> Staring at the options we have only three options for the CAN XL support aka "xl
>>>> on":
>>>>
>>>> 1. Providing CC/FD/XL bitrates => ES on, TMS off (mixed-mode)
>>>>
>>>> 2. Providing only CC/XL bitrates => ES off, TMS off (CANXL-only)
>>>>
>>>> 3. Providing only CC/XL bitrates => ES off, TMS on (CANXL-only)
>>>
>>> Why isn't
>>>
>>>     4. Providing only CC/XL bitrates => ES on, TMS off
>>>
>>> a valid option?
>>
>> I had an off-list discussion with Stéphane and other PEAK System experts in June
>> and the outcome was that CC/XL bitrates with ES on and TMS off is possible (only
>> with the PEAK CAN XL IP core!) but will result in a nightmare for support teams.
> 
> I will start by challenging this assertion.
> 
> Looking at the X_CAN datasheet, I see:
> 
>    1.4.5.22.2 Classical CAN
> 
>    All Classical CAN TX messages are either accepted or rejected, see
>    TX_FILTER_CTRL0.CC_CAN bit register. There is no other option for such
>    Classical CAN protocol. The TX filter elements are only used
>    for the CAN XL protocol.
> 
>    1.4.5.22.3 CAN FD
> 
>    All CAN FD messages are either accepted or rejected, see
>    TX_FILTER_CTRL0.CAN_FD bit register. There is no other option for the CAN FD
>    protocol. The TX filter elements are only used for the CAN XL
>    protocol.
> 
> Did you try those?
> 

For what reason? This is a detail of how Bosch creates there filtering 
but has nothing to do with what makes sense on the bus.

>> The CAN bus will crash if it receives a CAN FD frame.
> 
> I do not understand what you want to prove here. Isn't this the expected behaviour?
> If you are in XL with error signaling off and receive a CAN FD frame, does it
> crash the bus?

The point is: If you have no valid FD bitrate setting and the controller 
receives a FD frame with BRS=on how can this work? It does not work. Simply.

> If you are in XL with TMS on and receive a CAN FD frame, does it crash the bus?

See the table from Stéphane.

> The same goes with Stéphane's observation. Where is the problem? Which
> observation does not meet the expectations?
> 
>> This is basically the same with the Bosch X_CAN IP core where you need to enable
>> CAN FD for performing the mixed-mode. What would you set as a FD bitrate there?
>> There is no "nothing" to be set into the registers. You might set 2MBit/s as
>> default but that might crash either when it doesn't fit.
> 
> Once you set the TX_FILTER_CTRL0.CAN_FD bit, all the CAN FD frames will be
> discarded and the FD bitrate will never be used. What should you put in the
> register? That is not my problem. If the X_CAN is well designed, it should be OK
> to leave those to zero. If you still need to put some dummy values, complain to
> the X_CAN team, not to me.
> 
>> Looking back in our older discussions with Stéphane I found this:
>>
>> https://lore.kernel.org/linux-can/
>> DBAPR10MB41879125DC7369359E4AB256D467A@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM/#t
>>
>> Stéphane wrote:
>>
>> ---
>>
>> According to [3] lines 170-184, the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL flags
>> are not mutually exclusive, so why introduce CAN_CTRLMODE_XL_ERR_SIGNAL [2] when
>> the combinations of CAN_CTRLMODE_FD and CAN_CTRLMODE_XL would allow us to deduce
>> this?
>>
>> Indeed:
>>
>> can_priv->ctrlmode & (CAN_CTRLMODE_FD|CAN_CTRLMODE_XL) ==
>>
>> CAN_CTRLMODE_FD                    CANFD mode (n/a)
>> CAN_CTRLMODE_XL|CAN_CTRLMODE_FD    mixed-CANXL => error_signaling=ON
>> CAN_CTRLMODE_XL                    pure-CANXL => error_signaling=OFF
>>
>> ---
>>
>> With the CAN_CTRLMODE_XL (pure-CANXL) the ES is always off and the TMS becomes
>> an option to be switched on (default off).
>>
>> And the more I think about it, the more I would like to go for this solution.
>>
>> This setup covers all Bosch use-case slides and Bosch CAN XL IP core
>> documentations (e.g. with the 1.5.5.3 Operating Mode table).
> 
> You are referring to those slides, right?
> 
> https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/can_xl_1/20230717_can_xl_overview.pdf
> 
> I see in slide 16:
> 
>    Error Signaling: Software Configurable: ON/OFF

Yes. Of course! As CAN XL can be used in mixed-mode together with CAN FD 
and in CANXL-only mode. And for those two cases you need to set that bit 
in the controller accordingly.

But you are mixing different thing here:

1. The API to configure CAN FD and CAN XL in Linux
2. The API of the CAN XL controller

Item 1 is on a different level.

> If you are just referring to the example use cases of slide 24, then no. You
> should not be tunnel-visioned on a single slide when some other slide clearly
> states differently.

It does not. And please do not name me tunnel-visioned.
You have no such system on your desk to work with and you are 
over-engineering the CANXL-support with useless options trying to 
interpret the ISO specification.

Also the fact that the restricted mode is required for the CAN XL 
controller. The Linux kernel is not an ISO 11898 compliance checking tool.

> And in which world does an *example* use case in a slide deck take precedence on
> the ISO standard? I am sorry, but taking a random slide to disprove what the
> standard requires is not a receivable argument.
> 
>> And we can omit the introduction of the CAN_CTRLMODE_XL_ERR_SIGNAL flag as this
>> can be retrieved internally from CTRLMODE_XL and CAN_CTRLMODE_FD to be set into
>> the controller registers.
>>
>> Not defining the FD bitrate in the mixed-mode causes more harm (to the system
>> and the CAN bus itself) than urging the user to define it. Even if he doesn't
>> use CAN FD frames.
> 
> I also want to challenge this. You are claiming that the error signaling should
> be an implicit value. What if someone requires error signaling because of some
> safety requirements?
> 
> Here you are just silently turning off a safety feature. How is the end user
> meant to see the connection between disabling CAN FD and error signaling? By
> dropping the flag, we also loss the reporting. No more way to see in the netlink
> interface if error signaling is on or off.

You have no idea what you are talking about when you reference a safety 
feature here. There is a mixed mode with error-signalling and we have a 
CANXL-only mode which used an improved error recognition.

https://can-cia.org/fileadmin/cia/documents/proceedings/2020_mutter.pdf

And this has nothing to do with safety.

> The more I think about it, the more I am getting convinced that silently turning
> off a safety feature and hiding its value is nothing but a bad decision.

No.

>> In the (really unlikely) case that someone shows up with a valid use-case (like
>> len8_dlc) and separately wants to fiddle with the ES flags, we might introduce
>> such a flag later. But I bet this will not happen.
> The reality is that the people on the linux-can are a small community and the
> security/safety researcher is another small community. And the intersection of
> those two communities is rather small.
> 
> Before joining the linux-can mailing list, I was well aware of the lack of the
> len8_dlc and the TDC, and so were the people around me. But no one reported the
> problem, mostly because none of us were familiar with open source communities
> and we were all using some alternatives (proprietary drivers…)
> 
> Once I showed up and implemented those features, we saw people using those.

Great. Then lets wait if people need more than the implicit 
error-signalling.

> My point here is that taking the request on the linux-can mailing list is not a
> good benchmark to measure if people use a feature or not. At least, this is what
> occurred for the len8_dlc and the TDC and I see no reason for this to be
> different here.
> 
> (...)
> 
>> Either CAN CC or CAN FD with ES=off are marked as an "invalid configuration" in
>> the 1.5.5.3 Operating Mode table. And I'm pretty sure the CAN XL inventor's
>> implementation of the CAN XL IP core is compliant with the standard here. Maybe
>> the standard is unclear in this topic or left some details.
> 
> 1.5.5.3 also shows that FDOE is on whenever XLOE is on (even if error signaling
> is off or if TMS is on). Does it mean that you can always send FD frames? No.

Maybe the Bosch controller goes into an error, when the FDF bit is 
active on the bus without having FD enabled. You have to keep the 
bitstream in mind that has an FDF bit before getting to the XLF bit.

> That table can just not be used in isolation.
> 
> What is not clear here is the 1.5.5.3 Operating Mode table, not the standard.
> 

No, but it clearly shows invalid configurations. Maybe you can focus on 
those.

>> What is your interpretation of the standard here?
> 
> It is not an interpretation. The standard clearly require that error signaling
> should be configurable.
> 
>> What do you think has to be supported beyond the features that Stéphane and I
>> suggest?
> 
> FD off + XL on + error signaling on.

This is mixed-mode. Mixed-mode is FD/XL controllers sharing the same 
segment and can talk CC/FD (FD-controllers) and CC/FD/XL (XL-controllers).

Removing the FD bitrate in this setup leads to problems, when BRS is 
used by anyone.

>>> I see this a bit like the can_frame->len8_dlc thing. Should you use DLCs greater
>>> than 8 in production code? Hell no! But I still want the implementation to give
>>> me this option so that I can do my weird tests.
>>
>> Ack. But so far I do not see such weird options. And introducing code into the
>> kernel there is no user for and that's potentially only adding complexity in the
>> API that might lead to misconfiguration is not well-received.
> 
> It seems to me that Stéphane is able to use it and that you should also be able
> to by using TX_FILTER_CTRL0.CAN_FD. And I could also test it with my dummy-can
> driver. That should be enough testing, right?
> 
> 
> I made my mind here. It seems to me that you are tunneled-visioned on table
> 1.5.5.3 when the other sections of your datasheet clearly point out that you can
> deactivate CAN FD using TX_FILTER_CTRL0.CAN_FD. If you just partially read your
> datasheet to then jump to some conclusion, I would not feel confident to follow
> this.
> 
> The process to publish an ISO standard is strict with many domain expert
> involved. I do not think that any of us here is smarter that the combined
> mindset of the ISO 11898 committee. I would need a stronger argument to convince
> me that the ISO committee did a wrong design choice into making this error
> signaling configurable.

I'm also working in ISO committees. And some things sometimes are left 
undocumented as those domain experts simply could not imagine why 
someone would discuss not configuring the FD bitrate in the mixed-mode, 
like you do it here. You are exaggerating the discussion.

And again: Error-signalling is configurable in the CAN controller. Not 
to play with weird options but to differentiate between mixed-mode and 
CANXL-only mode.

And the different invalid configurations on the X_CAN mode register 
show, what works together and what does not work.

I'm really wondering if I am tunneled-visioned or if you are hunting a 
white rabbit.

Best regards,
Oliver


