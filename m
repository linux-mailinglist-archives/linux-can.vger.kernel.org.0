Return-Path: <linux-can+bounces-1177-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8B894BE7F
	for <lists+linux-can@lfdr.de>; Thu,  8 Aug 2024 15:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE72E1C23B8F
	for <lists+linux-can@lfdr.de>; Thu,  8 Aug 2024 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526D018C90B;
	Thu,  8 Aug 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=st.oth-regensburg.de header.i=@st.oth-regensburg.de header.b="L4gRvjDz"
X-Original-To: linux-can@vger.kernel.org
Received: from b2752.mx.srv.dfn.de (b2752.mx.srv.dfn.de [194.95.235.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F971487C8
	for <linux-can@vger.kernel.org>; Thu,  8 Aug 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.95.235.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123548; cv=none; b=j7YQNJZGGfbUZ3CekHyxudO2aRIXe7jIc1ycCAU5RciXOUFfoOVcRw0f6CI2i4Qf33NL2YCK2JEyvkTjjznd5ATUi3QQrPePlZ2gHyP7O5HIQlTW6VRWLPQdHQbbTj7ZSSRvIc/JJRQ43u0OuwXAHXwavRbYCZTjg75le5CMS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123548; c=relaxed/simple;
	bh=6p476bRSOfDBjUoKH5neHOni+IcMfhe7AndUTC2N/7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SSekP+U0PYiDZ3MTKf+8jM+nvezMsw3vgJq7XXChtaOTjtElxQSGuqU0p57nPiwOUJHdvRzaogxss0GLQtJWPkmVJDLv+j8gf13ON1hTUg3gaztq5zsSr6cmnlwIKmfVREw7MgAXmWDyMV0K6k1r80cHmF45DSGcHATHQjEBtT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=st.oth-regensburg.de; spf=pass smtp.mailfrom=st.oth-regensburg.de; dkim=pass (2048-bit key) header.d=st.oth-regensburg.de header.i=@st.oth-regensburg.de header.b=L4gRvjDz; arc=none smtp.client-ip=194.95.235.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=st.oth-regensburg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=st.oth-regensburg.de
Received: from mta01.hs-regensburg.de (mta01.hs-regensburg.de [194.95.104.11])
	by b2752.mx.srv.dfn.de (Postfix) with ESMTPS id E3E553E0155;
	Thu,  8 Aug 2024 15:17:59 +0200 (CEST)
Received: from E16S03.hs-regensburg.de (e16s03.hs-regensburg.de [IPv6:2001:638:a01:8013::93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client CN "E16S03", Issuer "E16S03" (not verified))
	by mta01.hs-regensburg.de (Postfix) with ESMTPS id 4WfnfH2p0Szy8H;
	Thu,  8 Aug 2024 15:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=st.oth-regensburg.de; s=mta01-20211122; t=1723123079;
	bh=WL6+0uMWHyswd0JF7krklGtmx42SRON0M6JVTuoeUOY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:From;
	b=L4gRvjDzhUS4SC8Z7rFg1+li8i4uzXdqBVsRrZoypV2j2Xp/TGy5pK5jc/G2TGiQa
	 0QDVMx6yp5st+y6J8P/Enbw58SC4Flbgwms54vLDSEt4yxy4Tom1hDEL3ss1QAWAzV
	 IjcPdLEtp3i6ZTlQNhHdTkEOuJN8W6AhLSuzEqkJ7fgbcDlAGx4gWqeuhHUTrs8WCG
	 YaO9SiG1IQNApZOL4v/onW1KS5gcrqbvnTnVuerYj3I5J5bd/DpH7CpcKIECUbmyAG
	 x3neW6HQR68+0XoVLqUtodFD9OxkBMvO8Tx2yZTYJMviMXsCcnsu5MLYXU5mZC2eLg
	 VwVaZK+GWqL8A==
Received: from [IPV6:2003:f7:1727:8a00:d2ab:d5ff:fe1f:cec1]
 (2001:638:a01:8013::226) by E16S03.hs-regensburg.de (2001:638:a01:8013::93)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 15:17:58 +0200
Message-ID: <676d5a7a-643d-423d-bada-95f3ec95e4d5@st.oth-regensburg.de>
Date: Thu, 8 Aug 2024 15:17:58 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: Introducing new Kernel Module for CAN over IP Networks
To: Vincent Mailhol <vincent.mailhol@gmail.com>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Ralf Ramsauer
	<ralf.ramsauer@oth-regensburg.de>, Wolfgang Mauerer
	<wolfgang.mauerer@oth-regensburg.de>, "nils.weiss@dissecto.com"
	<nils.weiss@dissecto.com>
References: <77a04054acea40a886d371adbd8d25d1@st.oth-regensburg.de>
 <CAMZ6RqK00=EKvCR8XBW7Vre5tSxsrD41LuGObV_5e=hYOKdSSA@mail.gmail.com>
 <8b96193b-082e-4c7f-b8ba-666580aae3e6@st.oth-regensburg.de>
 <CAMZ6RqK1keG5EuFMOnVo5j0zyAWQSYsZhruHBQ_dUZdx5xEw6w@mail.gmail.com>
Content-Language: en-US
From: Matthias Unterrainer <matthias.unterrainer@st.oth-regensburg.de>
In-Reply-To: <CAMZ6RqK1keG5EuFMOnVo5j0zyAWQSYsZhruHBQ_dUZdx5xEw6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: E16S03.hs-regensburg.de (2001:638:a01:8013::93) To
 E16S03.hs-regensburg.de (2001:638:a01:8013::93)



On 07-08-2024 12:25, Vincent Mailhol wrote:
> On Sat. 27 Jul. 2024 at 12:17, Matthias Unterrainer
> <matthias.unterrainer@st.oth-regensburg.de> wrote:
>> Hi Vincent,
>>
>> apologies for the late reply.
> 
> No problem. I am myself abroad until the end of August. My answers
> will also be delayed.
> 
>> On 07-07-2024 17:23, Vincent Mailhol wrote:
>>> Hi Matthias,
>>>
>>> On Fri. 5 Jul. 2024 at 02:47, Matthias Unterrainer
>>> <matthias.unterrainer@st.oth-regensburg.de> wrote:
>>>> Hi Linux-CAN Community,
>>>>
>>>> my name is Matthias and I recently developed a kernel module during my Bachelor's thesis that allows for transferring CAN frames over IP networks, similar to userland tools like socketcand [0] or cannelloni [1].
>>>>
>>>> I wrote the thesis at dissecto GmbH [2], a german Startup that specializes in security diagnostics and analytics for embedded systems, primarily within the automotive industry.
>>>>
>>>> The idea behind the project is that dissecto has developed a hardware device that can be connected to a CAN bus and acts as an ethernet gateway to the bus. It is capable of capturing the CAN traffic along with the corresponding timestamps and send this data via UDP or it can receive CAN frames via UDP as well and pass them on to the CAN bus.
>>>> This allows for remote interaction with a CAN bus, as well as an accurate analyses of CAN traffic, as packets contain precise time stamps.
>>>>
>>>> An architectural design decision was to develop it as kernel module because of lower latencies and high throughput.
>>>
>>> Question: did you consider Packet MMAP?
>>>
>>>     https://docs.kernel.org/networking/packet_mmap.html
>>>
>>> Most of the overhead comes from the syscall context switch between the
>>> user and kernel land and Packet MMAP is exactly designed to bypass
>>> this. Actually, a few months ago, I started to rewrite the can-utils's
>>> candump to use Packet MMAP, but I never finished it.
>>
>> No, at the time I did not consider Packet MMAP. From my understanding
>> Packet MMAP is used for userspace applications. But the module has to
>> modify the timestamps of the CAN frames as they appear on the interface,
>> which, as far as I know, is not possible from userspace.
>> Please correct me if I am mistaken, but because of that I do not think
>> Packet MMAP or any userspace application for that matter could actually
>> be used here.
> 
> Can you explain this in more detail? The precise CAN timestamps are
> all available from the user land. Some drivers even have the hardware
> timestamps as generated by the device. Why do you need to *modify* the
> timestamps?
> 

I have to modify the timestamps, because I want the CAN-frames to have 
the timestamps they had when they originally appeared on the "source" 
device, which is not the same device I am modifying the timestamps on.

An example setup for this would be, that we have two devices and one of 
them, the "source" device, has a CAN-Bus we want to capture the traffic 
from.
On that device we record the CAN-frames together with their timestamps.
Then all of this is sent to the second device and recreated there.
Meaning all the CAN-frames appear with the timestamps from when they 
originally appeared on the "source" device.

I hope this makes it a bit clearer what I am trying to accomplish.

>>>> For example, my measurements show that the average time it takes a CAN frame to get processed by the module is just about 1/4 of the time it takes applications like socketcand or cannelloni.
>>>>
>>>> We have published the module on GitHub [3], and would appreciate your feedback and thoughts.
>>>>
>>>> If anyone is interested in this functionality for the same or similar use cases, please don't hesitate to contact us.
>>>>
>>>> Best regards
>>>> Matthias Unterrainer

