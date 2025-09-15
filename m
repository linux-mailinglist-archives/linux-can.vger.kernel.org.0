Return-Path: <linux-can+bounces-4706-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAF8B583D6
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 19:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CBBA4E050A
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 17:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097552777F3;
	Mon, 15 Sep 2025 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="lvLJqE0F"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57BE19ABD8;
	Mon, 15 Sep 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958132; cv=pass; b=b22ceO80E+ve8WPFNzW3n66mQJ8EkMPtCaah5QWNQ9Q5KTOWq7C/oZ+zkIifOn+AhpGI69G1unS3ZAGnEfLpEOuVMKlLu7x5jQYTmbrI773WIkJWtxs+PqgeRdDzYLuGUQsmps5YyjaWenbAx6ukB0I2RCga/TlW7mG4n7Lb/T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958132; c=relaxed/simple;
	bh=PVZ09Q/8Qfy1kLq53yq1kvo7FXr3QyBN2KZEt0mwdHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VR0IhpeiYogL0zoqISCymuX6PG4no6Ejuguktzro1vSLN9ViMGaUle5ovLROyvLWPFViuowto5EeNB/vxVTGQDOLB7LSRJrZPi8ydF0C7VuKXW8W3gAWRAyU7INTsg/LSCpCco+e9dDxgbzn8ejUofhOTpHpF6k9isn6U0qYzho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lvLJqE0F; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757958122; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HQP+K/2MPxXI7kSsHpzLKHCZ6OG91P6QiY19hYnXnpGblquiyldy/cvfYR3hu+5pve
    uzgyT95g8v6tk+OTAlo0MwBRMBfdfaKn7zqcyEzjdYnj/bNNYK8lmZEVlzEZdoxLqyvs
    +tR2nwhongO67VzZ08rnEsDCvH7iGAntkTbd99+as97v05hxN7Kud0bhoasnJ3ytj2WF
    Pv1+/ab9BPWnnV5U0DTJ745lNLdT5G4yRCCugoBNhw39U0mJTNoUiEpI15snyHgRU5Ne
    O4ARmiYVj1BZVqcIDZmsFSkC7M0D5XP2uxGoL/Z+dVoSKQfwLtytHg3mAgQ3CYCOBj/8
    7p2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757958122;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BSAmTJdcUddD1lBj1f/9Xw263hBNNCfzKGLKoKWMusw=;
    b=VFSNHre+dxIAO69CSiRwouNGzc5W+b/uBEnGssKIbjZwNgQtf5ZDSFl05ubGz554ee
    h7cSNp1AgXNlZq295mL0kxp6a+la65PHzl8tCLIGlBFX1GJoLvGD0CDAyjNUTODMqMk8
    Tum++dpO0Req0aTUrPNhD9AjAMq+dHh2f3/ixozp6flognCUiQB89OVaYUa8nVRbD8Tg
    ZRw7fFdxGRCrzLugbDm5v4GeDgmoZqxCpxezAmTCotZDF4RMSGD2peCeaY6494Z4+2Yi
    f2dc9+KPbzj6O3d5qAQMKFwCumZfvL49AwItRciPFVeblP8C7N2XJ5k+Nazi6WE5uKq8
    75Uw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757958122;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BSAmTJdcUddD1lBj1f/9Xw263hBNNCfzKGLKoKWMusw=;
    b=lvLJqE0FyQicUQjbFOF8jlO4DJeQiyO5fg0L197HFV8BIHlCrcwF9TJJPXToFsj03v
    KX2oOnx1+f/U0pOI6dRL6UyXkQ3/xDbmJUdAuZt+cKek2jtrvGrjAEwygiYrP+9tlKId
    3odoYENaDiQ80xfKgV3r8zn7ZS0Mya1mIK+iZdIaruxjPvX/ugbCWj/ojpnf2uW/ucoB
    hMRtKxCDux7HLEUKeELSwgNcjhrUUAqz+opzNoLZs8jmJ4LwaDYXrR7uCSBrWPqgaduC
    4ey16X8iOUJx1Hj4whJAaxACxW44ib3SInGu12QsQrAQKw8zqJ6HWrE1dWtgC/MEiZDB
    iv5Q==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMr5owMnk64sm8VF6OpcIrgdno+M3mNGEGSIofQp0UJwtSeLY="
Received: from [IPV6:2a02:b98:8b0e:d800:856:bd03:6d59:abd2]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K2a23218FHg12xX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 15 Sep 2025 19:42:01 +0200 (CEST)
Message-ID: <6e8e18e4-3517-4c6c-8457-a4278b906f5d@hartkopp.net>
Date: Mon, 15 Sep 2025 19:41:56 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] can: raw: use bitfields to store flags in struct
 raw_sock
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250915-can-raw-repack-v1-0-5ea293bc6d33@kernel.org>
 <20250915-can-raw-repack-v1-2-5ea293bc6d33@kernel.org>
 <f96cd163-0364-4c14-882b-48c3f8e0f05a@hartkopp.net>
 <f0a34514-19da-4c73-9cd4-ae220fed6447@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <f0a34514-19da-4c73-9cd4-ae220fed6447@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15.09.25 12:47, Vincent Mailhol wrote:
> On 15/09/2025 at 19:16, Oliver Hartkopp wrote:
>> On 15.09.25 11:23, Vincent Mailhol wrote:
>>> The loopback, recv_own_msgs, fd_frames and xl_frames fields of struct
>>> raw_sock just need to store one bit of information.
>>>
>>> Declare all those members as a bitfields of type unsigned int and
>>> width one bit.
>>>
>>> Add a temporary variable to raw_setsockopt() and raw_getsockopt() to
>>> make the conversion between the stored bits and the socket interface.
>>>
>>> This reduces struct raw_sock by eight bytes.
>>>
>>> Statistics before:
>>>
>>>     $ pahole --class_name=raw_sock net/can/raw.o
>>>     struct raw_sock {
>>>         struct sock                sk __attribute__((__aligned__(8))); /*
>>> 0   776 */
>>>
>>>         /* XXX last struct has 1 bit hole */
>>>
>>>         /* --- cacheline 12 boundary (768 bytes) was 8 bytes ago --- */
>>>         int                        bound;                /*   776     4 */
>>>         int                        ifindex;              /*   780     4 */
>>>         struct net_device *        dev;                  /*   784     8 */
>>>         netdevice_tracker          dev_tracker;          /*   792     0 */
>>>         struct list_head           notifier;             /*   792    16 */
>>>         int                        loopback;             /*   808     4 */
>>>         int                        recv_own_msgs;        /*   812     4 */
>>>         int                        fd_frames;            /*   816     4 */
>>>         int                        xl_frames;            /*   820     4 */
>>>         struct can_raw_vcid_options raw_vcid_opts;       /*   824     4 */
>>>         canid_t                    tx_vcid_shifted;      /*   828     4 */
>>>         /* --- cacheline 13 boundary (832 bytes) --- */
>>>         canid_t                    rx_vcid_shifted;      /*   832     4 */
>>>         canid_t                    rx_vcid_mask_shifted; /*   836     4 */
>>>         int                        join_filters;         /*   840     4 */
>>>         int                        count;                /*   844     4 */
>>>         struct can_filter          dfilter;              /*   848     8 */
>>>         struct can_filter *        filter;               /*   856     8 */
>>>         can_err_mask_t             err_mask;             /*   864     4 */
>>>
>>>         /* XXX 4 bytes hole, try to pack */
>>>
>>>         struct uniqframe *         uniq;                 /*   872     8 */
>>>
>>>         /* size: 880, cachelines: 14, members: 20 */
>>>         /* sum members: 876, holes: 1, sum holes: 4 */
>>>         /* member types with bit holes: 1, total: 1 */
>>>         /* forced alignments: 1 */
>>>         /* last cacheline: 48 bytes */
>>>     } __attribute__((__aligned__(8)));
>>>
>>> ...and after:
>>>
>>>     $ pahole --class_name=raw_sock net/can/raw.o
>>>     struct raw_sock {
>>>         struct sock                sk __attribute__((__aligned__(8))); /*
>>> 0   776 */
>>>
>>>         /* XXX last struct has 1 bit hole */
>>>
>>>         /* --- cacheline 12 boundary (768 bytes) was 8 bytes ago --- */
>>>         int                        bound;                /*   776     4 */
>>>         int                        ifindex;              /*   780     4 */
>>>         struct net_device *        dev;                  /*   784     8 */
>>>         netdevice_tracker          dev_tracker;          /*   792     0 */
>>>         struct list_head           notifier;             /*   792    16 */
>>>         unsigned int               loopback:1;           /*   808: 0  4 */
>>>         unsigned int               recv_own_msgs:1;      /*   808: 1  4 */
>>>         unsigned int               fd_frames:1;          /*   808: 2  4 */
>>>         unsigned int               xl_frames:1;          /*   808: 3  4 */
>>
>> This means that the former data structures (int) are not copied but bits are set
>> (shifted, ANDed, ORed, etc) right?
>>
>> So what's the difference in the code the CPU has to process for this
>> improvement? Is implementing this bitmap more efficient or similar to copy the
>> (unsigned ints) as-is?
> 
> It will indeed have to add a couple assembly instructions. But this is peanuts.
> In the best case, the out of order execution might very well optimize this so
> that not even a CPU tick is wasted. In the worst case, it is a couple CPU ticks.
> 
> On the other hands, reducing the size by 16 bytes lowers the risk to have a
> cache miss. And removing one cache miss outperforms by an order of magnitude the
> penalty of adding a couple assembly instructions.
> 
> Well, I did not benchmark it, but this is a commonly accepted trade off.

Ok.
Most accesses of those values like ro->fd_frames are read-only anyway, 
which might add an additional AND operation with a constant value.

Therefore your suggested changes are not in the hot path anyway and the 
ro->fd_frames = !!flag operation is executed at socket creation time only.

Generally it is interesting the the compiler can handle bits in this way.

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks!

Oliver

> 
> Yours sincerely,
> Vincent Mailhol
> 


