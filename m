Return-Path: <linux-can+bounces-5402-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13336C5EDC8
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 19:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 968A34F3955
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 18:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1542D8375;
	Fri, 14 Nov 2025 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="U7pyukQA";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="e2VsVatK"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08E274B53
	for <linux-can@vger.kernel.org>; Fri, 14 Nov 2025 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144458; cv=pass; b=grhm97UwBpB6IHC53VuvmwAlGTUSn2WaPv0YbbyaNUPy6VZKN8KnVDuXwdbDylpHqgNvYjXmMrKojinOVmeH5AJjJkSZbSnxjQ8m6smRNdVtkMIZJLQOacy5aUxCRDfNgXhg3M23flMI64ANbz4OBMygmwoWoSKO21GB/sxPW4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144458; c=relaxed/simple;
	bh=4hEdOEoNLBOGk4UDlxq7yTS9PGJlChZm5MSa9plWDrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHfCjFYTG1kUtNHR12lIzBYdHWyh9ZqNF1KruN8Id5CngzJ/lkYFYojxQcc7WnvxjzyrkXZC+sCEPH1QUBARruAgIPx1IGUkZOMJ3pkjfBt09mBFxSylCwAmlMqrSlrjhf+r1Ukqy3r8+Td56RHtD7iuPKLYnJ87bVO+9JKDNxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=U7pyukQA; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=e2VsVatK; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763144433; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JIJWtHczJp0cvTIeqXkQ/w1QV8EdjTBqEbV3J6sywxNl5ibbvld3qBM/97YBLisGjJ
    mfZ8DcuIc8v7tmGmr194Qt+7QgMnNgd7DJwLEx1eRsNy0nCMxwdfhNm9uMMUch8ywr5u
    OzB9KgvauenoiRbFLVR6zqoaONvvQfVGK4nBT1mf8vUOCymh0KPf/e2Y1jcRkgzp3SR/
    YNulthi8LtqDEzoazPPhgDFNjJSIhRFtFtd7+D0P3zvy4aHNndGPhnrVDPTY569A1Nxc
    YY/M5ZlTNhFvxdVIsHa0SvmnjC2tvuX3Kjf20wLxxE6mJqyiTNX2ljKP187HjF/b8hAm
    rAww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763144433;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EUfHolnqtLL0ifX/B8nqERZARRlJ7inDQ+pAZ1D4a9M=;
    b=oR0utoXvkYtwOxP0SpbCKl49O5skmgA+qWtujLHaaWxUq8b1Ie8qb7B59YONJfT5UH
    WydSxsiPZ2uadb4xADxC/8T7hrKDRJEpyB1rnIM4mNYB7rSKL955AygKDoHpGcc8J1ci
    h6ed6aabOGOdVRDEUcDcfTjlXwqWiurczSdAjdTO1Uuh+VXtrrk4l99z50bsTyNNV8cu
    QL5hiSO/bR1h3NcDtQgZLwt8RFGrpBOPexjPWmLwnxpo3qpsvKDA2P1eFul/1xczCDN4
    Nv2ZXybq7lOAnvb/E4ZpG0p7Au1FPcjg61T0NmEyh0uG0bhvzKk1k701p+1wXob8ZDZ7
    uJZw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763144433;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EUfHolnqtLL0ifX/B8nqERZARRlJ7inDQ+pAZ1D4a9M=;
    b=U7pyukQAmb8ljybM9hIZlSXbnene2Q+xFVgChAPIkdvOeOtSNz0neZuD80vqqIOYMC
    wEeiACYk8rplxjCMUPo+1vvZvHiYklvFknkT/9WzruoRNlNv/8nFZVvtgAvZubh5yIoL
    ScP9CjOcmtfJ67mPcGI7Rsr9DKmoPyodzlKV2dK+EMgt8wnyW+ix6Q5ubduzxnhLIME+
    1Mraqr0fIuTluDAY1K7U3coUbsOO6yca2ZoshXfCdIUpCfShw8IQ/86k9Aa0SVW5WUqi
    Png/mmDMy/CKQ8IQ534wQ33FxXaUky9sJGLmMY3SX9wrsG88Uppcu9awaNdbzD1brDFj
    +yKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763144433;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EUfHolnqtLL0ifX/B8nqERZARRlJ7inDQ+pAZ1D4a9M=;
    b=e2VsVatKQF9ny7pD5zlcyuzT6+NFovNwZhN/fbTpMp3oiP8PD4BpQJwSx2eyPcbnpB
    eg53/jSMZDC0mrGWURBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AEIKWcHh
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 14 Nov 2025 19:20:32 +0100 (CET)
Message-ID: <6d351ef7-7716-4f66-8930-1c90557b3e88@hartkopp.net>
Date: Fri, 14 Nov 2025 19:20:27 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC remove CAN_CTRLMODE_XL_ERR_SIGNAL
To: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
References: <1567529787.640577701.1763133420441.JavaMail.root@zimbra65-e11.priv.proxad.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <1567529787.640577701.1763133420441.JavaMail.root@zimbra65-e11.priv.proxad.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Stéphane,

many thanks for your effort with the real-world measurements in your 
test setup!!

On 14.11.25 16:17, Stéphane Grosjean wrote:
> Hi,
> 
> If I may say so:
> 
>>> Why isn't
>>>
>>> 4. Providing only CC/XL bitrates => ES on, TMS off
>>>
>>> a valid option?
> 
> It works... But when only CANXL controllers (all configured in this way) are stuck to the wire! They communicate in a kind of CANFD++ protocol that allows the same (high) data rates but with 2KB frames.
> 
> When such 2KB CANXL frames are written to the bus, any CAN 2.0 controller will indicate frame errors, whereas a controller configured for CANFD will not be affected (no error or frames raised)

Yes. This is the mixed-mode (FD/XL) scenario. CAN CC controllers can not 
handle FD/XL frames. Therefore the mixed-mode examples on the Bosch 
slides only consist of XL and FD controllers where the latter are XL 
tolerant.

> On the other hand, writing CANFD frames *without* BRS but DLC>8 is OK (the CANXL node reads them as CAN_CC frames of course) while writing CANFD frames with BRS obviously turns to error on the bus. CAN 2.0 node turns into error in every case.

When BRS=on the FD data bitrate settings are needed, which have not been 
configured. Well this is then expected.

> Finally, writing CAN 2.0 frames is ok for everyone in that configuration.
> 
> I've tried to summarize all of this in the following tables:

> CC/XL bitrates + ES=on TMS=off
>                     
> CANXL1             CANXL2            CANFD1             CANFD2             CANCC
> writes 2KB frames  reads 2KB frames  no error/no frame  no error/no frame  frm errors
> reads DLC>8        reads DLC>8       writes DLC>8       reads DLC>8        not connected
(the above seems to be the BRS off case)> frm errors         frm errors 
       writes DLC>8       frm errors         frm errors
(the above seems to be the BRS on case)> reads frames       reads frames 
      reads frames       reads frames       writes frames

Summarizing this is the CC/FD/XL mixed mode (ES=on) which fails when the 
FD bitrates are unset.

> Once ES is turned off, then you obviously enters a new protocol, so communication is less mixed:> > CC/XL bitrates + ES=off TMS=off
> 
> CANXL1             CANXL2            CANFD1             CANFD2             CANCC
> writes 2KB frames  reads 2KB frames  no error/no frame  no error/no frame  not connected

CAN FD is CAN XL tolerant and creates no error when it sees a CAN XL frame.

> stuff error        stuff error       writes DLC>8       reads DLC>8        not connected
> stuff error        stuff error       reads frames       reads frames       writes frames

What would be the use-case here? Hiding XL from FD traffic without BRS 
on the same CAN segment? O_o

> CC/XL bitrates + ES=off TMS=on (aka pure CANXL)
> 
> CANXL1             CANXL2            CANFD1             CANFD2             CANCC
> writes 2KB frames  reads 2KB frames  no error/no frame  no error/no frame  not connected
> stuff error        stuff error       writes DLC>8       reads DLC>8        not connected
> stuff error        stuff error       reads frames       reads frames       writes frames

Same here.

> Hope this helps,

Yes. It proves that broken setups are broken.

ES=on is used for mixed-mode (FD/XL) which also can handle CC frames 
(but with FD/XL controllers only)
And omitting the FD bitrates in mixed-mode turns out to be broken too.

ES=off is used for CANXL-only modes which can have TMS=off or TMS=on

Turning it upside down (not from the ES perspective):

CAN_CTRLMODE_XL|CAN_CTRLMODE_FD    mixed-mode (CC/FD/XL)
CAN_CTRLMODE_XL                    CANXL-only (optional TMS on)

And the error signalling state to be set into the CAN XL controllers 
configuration registers can be calculated by this function:

+static inline bool can_dev_err_signal_is_disabled(struct can_priv *priv)
+{
+    const u32 mixed_mode = CAN_CTRLMODE_FD | CAN_CTRLMODE_XL;
+
+    /* When CAN XL is enabled but FD is disabled we are running in
+     * the so-called 'XL-only mode' where the error signalling is
+     * disabled.
+     * The so-called CC/FD/XL 'mixed mode' requires error signalling.
+     */
+    return ((priv->ctrlmode & mixed_mode) == CAN_CTRLMODE_XL);
+}

The requirements and prerequisites are simple:

1. CAN_CTRLMODE_XL|CAN_CTRLMODE_FD -> needs CC/FD/XL bitrates and offers 
(X)TDC handling

2. CAN_CTRLMODE_XL -> needs CC/XL bitrates and offers

2a. TMS off (default) with XTDC handling

2b. TMS on with PWM handling

IMO the CAN_CTRLMODE_XL_ERR_SIGNAL patch should be completely omitted.

The valid/working use-cases can be completely met with the outlined 
simple CAN_CTRLMODE_XL / CAN_CTRLMODE_FD handling.

Best regards,
Oliver

> 
> -- Stéphane
> 
> 
> ----- Mail original -----
> 
> De: "Oliver Hartkopp" <socketcan@hartkopp.net>
> À: "Vincent Mailhol" <mailhol@kernel.org>, "Stéphane Grosjean" <stephane.grosjean@hms-networks.com>
> Cc: linux-can@vger.kernel.org
> Envoyé: Mardi 11 Novembre 2025 15:12:56
> Objet: Re: RFC remove CAN_CTRLMODE_XL_ERR_SIGNAL
> 
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
>> 4. Providing only CC/XL bitrates => ES on, TMS off
>>
>> a valid option?
> 
> I had an off-list discussion with Stéphane and other PEAK System experts
> in June and the outcome was that CC/XL bitrates with ES on and TMS off
> is possible (only with the PEAK CAN XL IP core!) but will result in a
> nightmare for support teams.
> 
> The CAN bus will crash if it receives a CAN FD frame.
> 
> This is basically the same with the Bosch X_CAN IP core where you need
> to enable CAN FD for performing the mixed-mode. What would you set as a
> FD bitrate there? There is no "nothing" to be set into the registers.
> You might set 2MBit/s as default but that might crash either when it
> doesn't fit.
> 
> Looking back in our older discussions with Stéphane I found this:
> 
> https://lore.kernel.org/linux-can/DBAPR10MB41879125DC7369359E4AB256D467A@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM/#t
> 
> Stéphane wrote:
> 
> ---
> 
> According to [3] lines 170-184, the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL
> flags are not mutually exclusive, so why introduce
> CAN_CTRLMODE_XL_ERR_SIGNAL [2] when the combinations of CAN_CTRLMODE_FD
> and CAN_CTRLMODE_XL would allow us to deduce this?
> 
> Indeed:
> 
> can_priv->ctrlmode & (CAN_CTRLMODE_FD|CAN_CTRLMODE_XL) ==
> 
> CAN_CTRLMODE_FD CANFD mode (n/a)
> CAN_CTRLMODE_XL|CAN_CTRLMODE_FD mixed-CANXL => error_signaling=ON
> CAN_CTRLMODE_XL pure-CANXL => error_signaling=OFF
> 
> ---
> 
> With the CAN_CTRLMODE_XL (pure-CANXL) the ES is always off and the TMS
> becomes an option to be switched on (default off).
> 
> And the more I think about it, the more I would like to go for this
> solution.
> 
> This setup covers all Bosch use-case slides and Bosch CAN XL IP core
> documentations (e.g. with the 1.5.5.3 Operating Mode table).
> 
> And we can omit the introduction of the CAN_CTRLMODE_XL_ERR_SIGNAL flag
> as this can be retrieved internally from CTRLMODE_XL and CAN_CTRLMODE_FD
> to be set into the controller registers.
> 
> Not defining the FD bitrate in the mixed-mode causes more harm (to the
> system and the CAN bus itself) than urging the user to define it. Even
> if he doesn't use CAN FD frames.
> 
> In the (really unlikely) case that someone shows up with a valid
> use-case (like len8_dlc) and separately wants to fiddle with the ES
> flags, we might introduce such a flag later. But I bet this will not happen.
> 
>>> Therefore we only need "tms" as an additional option when xl is on.
>>>
>>> The error signalling "on" automatically results from the availability of "fd on"
>>> and the FD bitrate.
>>>
>>> Examples:
>>>
>>> 1. Providing CC/FD/XL bitrates => ES on, TMS off
>>>
>>> ip link set can0 type can bitrate 500000 fd on dbitrate 2000000 xl on xbitrate
>>> 4000000
>>>
>>> 2. Providing only CC/XL bitrates => ES off, TMS off
>>>
>>> ip link set can0 type can bitrate 500000 xl on xbitrate 4000000
>>>
>>> 3. Providing only CC/XL bitrates => ES off, TMS on
>>>
>>> ip link set can0 type can bitrate 500000 xl on xbitrate 10000000 tms on
>>>
>>> That's simple and provides only the needed switches, which makes
>>> CAN_CTRLMODE_XL_ERR_SIGNAL obsolete in the netlink API.
>>>
>>> What do you think about this approach?
>>
>> What really bothers me here is that the ISO standard explicitly state that error
>> signaling is a configurable option. Making this an implicit option would result
>> in a somehow non-compliant implementation.
> 
> Yes. According to all the Bosch slides ES=on results in mixed-mode and
> ES=off results in CANXL-only. You need this bit to distinguish these two
> operation modes when using CAN XL (mixed or pure).
> 
> The fact that we need an arbitration bitrate for the CANXL-only modes
> does not imply we can send or receive CC frames (with ES off).
> 
>> I appreciate that for most of the use cases the error signaling can be inferred
>> from the other values, and this is what I tried to implement (c.f. the table of
>> default values which I put in my patch).
>>
>> But I want to leave room so that people who wants to push the standard to its
>> limits can.
> 
> Either CAN CC or CAN FD with ES=off are marked as an "invalid
> configuration" in the 1.5.5.3 Operating Mode table. And I'm pretty sure
> the CAN XL inventor's implementation of the CAN XL IP core is compliant
> with the standard here. Maybe the standard is unclear in this topic or
> left some details.
> 
> What is your interpretation of the standard here?
> What do you think has to be supported beyond the features that Stéphane
> and I suggest?
> 
>> I see this a bit like the can_frame->len8_dlc thing. Should you use DLCs greater
>> than 8 in production code? Hell no! But I still want the implementation to give
>> me this option so that I can do my weird tests.
> 
> Ack. But so far I do not see such weird options. And introducing code
> into the kernel there is no user for and that's potentially only adding
> complexity in the API that might lead to misconfiguration is not
> well-received.
> 
> Best regards,
> Oliver


