Return-Path: <linux-can+bounces-4497-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C44B45B69
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 17:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9129AA68330
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA332F7AAD;
	Fri,  5 Sep 2025 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELzK1Dto"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773C7306B04;
	Fri,  5 Sep 2025 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084333; cv=none; b=p39diY7R5b9fH0EbZ4lVqeL87AUgEt64TIuWuY3UGlCcMn/Kycgqev+MXzdUm/cz6R/WlBCVItqXXitUPnxPH8qpaFlFnwXITOVxOhF1uv6c67pOJcmMvG24/WPSBOaTgL1M4EAJCX11WFKeOzvqPy1ALeK5AQAR097OvalOYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084333; c=relaxed/simple;
	bh=mg0k12zBWTMKVIHace3F600FbAS2V+x7Sd+WtaH65dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqZQkDw/tOzGwZaiB/4TIueiU1uW+Hq3GVSvS5tVjWTboVFqo0fSHH6YFIidv9qlHDsIgFl53uTi4EG/FVOOa6guK6nG38I2AtmxWBrTqcbgSksEwGqXDpi4xLa0ogYmNu3fIRW6lsodO6i0Yg9PTGZw0JR3deNPi5n1oP1k8QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELzK1Dto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D822AC4CEF1;
	Fri,  5 Sep 2025 14:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757084333;
	bh=mg0k12zBWTMKVIHace3F600FbAS2V+x7Sd+WtaH65dA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ELzK1DtoX3Fnua56iq6tQ0clMGufaoqKH18IIDWNzaxdMAIVEdn4j72CfoaOv1TGX
	 V3rw1jPpkLcKPquyEYgxOVOM+i7XccubaJOPeOVuoeTurf212w26c58XQPyr+xHuGQ
	 mHsrPVZCbeAZ1I0PqErgNF8a6D37CbmngL+fXIKiUao0h4+sy/+DJgrHmmxylEYRz2
	 4n7vPFKtxnR4Za7Xw41k4xh6xuo3dyCqwFIRM7MCJprc0pt51Z/MO7uXMZnSV4KNP9
	 DjA2tYo2n9AvA1fHmZqeJ/evBoZE5I3Exr0NZ/yG8B+oGfSJn4XjVbwixR93psETkw
	 nA9GaZ8UjAL/w==
Message-ID: <6799c8a7-cc0e-4df0-aa08-10b948b58c4d@kernel.org>
Date: Fri, 5 Sep 2025 23:58:50 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] can: netlink: preparation before introduction of
 CAN XL step 2/2
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
 <6e4dcab9-d3d7-4c8b-99c1-f472bb7caa07@kernel.org>
 <e37c9890-823f-4a38-bdcc-c170dbe67e13@hartkopp.net>
 <88d2836b-2702-481f-b504-20c6efa5cb1a@kernel.org>
 <32fc8ebf-1cf5-41b0-b843-1af4821a8ddb@hartkopp.net>
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
In-Reply-To: <32fc8ebf-1cf5-41b0-b843-1af4821a8ddb@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/09/2025 at 20:11, Oliver Hartkopp wrote:
> On 04.09.25 11:18, Vincent Mailhol wrote:
> 
>> Concerning the CAN_CTRLMODE_XL_RRS, I am not sure if that one is needed. I still
>> have it in my WIP series but I am recently considering to remove it. The reason
>> is that when reading ISO 11898-1 having RRS configurable looks mandatory to me.
>>
>> In the logical Link control (LLC) this RRS bit is named FTYP (for Frame Type).
>> For example, CiA only mentions FTYP in their CAN XL knowledge page:
>>
>>    https://www.can-cia.org/can-knowledge/can-xl
>>
>> Contrarily to CAN FD's RRS which is indeed specified as being dominant and which
>> is just ignored in the LLC, the CAN XL FTYP/RRS is part of the LLC interface and
>> is meant to be configurable.
> 
> I double checked my XCANB CAN XL controller spec and indeed the RRS bit is part
> of every RX/TX FIFO element and the figures see it as configurable element too.
> 
>> Nothing in the standard tells us that this should be a dominant bit. I think
>> your intention was to add CAN_CTRLMODE_XL_RRS as a quirk for the devices which
>> expose this flag. But as far as I can see, it seems that a device which does not
>> expose it is just not compliant.
> 
> Let's see if we will find CAN XL IP cores where the engineers have a different
> view on this. I currently have a discussion on this RRS bit with the Vector
> support because the RRS bit is not visible in the CANalyser 19 GUI.
> 
>> If some day a device which can not set the FTYP/RRS flag appears in the wild,
>> then maybe we can add a flag which would specify that RRS is not configurable
>> (opposite logic as what you suggested). But as long as such a device do not
>> exist, it is better to add nothing.
> 
> ACK. After this discussion I would also vote to omit my glorious patch which
> added the CAN_CTRLMODE_XL_RRS flag. Let's see if we find a CAN XL controller
> that does not support the variable RRS bit in reading and writing. And if it
> shows up we can add this flag to handle it (similar to the fd-non-iso feature).

OK. Good that we reached out to the same conclusion :)

Because I already implemented all the logic, I will save the current RRS patch
somewhere in case we need to resurrect it some days.


Yours sincerely,
Vincent Mailhol


