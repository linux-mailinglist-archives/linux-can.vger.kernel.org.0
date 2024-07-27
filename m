Return-Path: <linux-can+bounces-1017-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6A993DEB8
	for <lists+linux-can@lfdr.de>; Sat, 27 Jul 2024 12:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D58B20F60
	for <lists+linux-can@lfdr.de>; Sat, 27 Jul 2024 10:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF844411;
	Sat, 27 Jul 2024 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=st.oth-regensburg.de header.i=@st.oth-regensburg.de header.b="ZFmvc7lk"
X-Original-To: linux-can@vger.kernel.org
Received: from c2752.mx.srv.dfn.de (c2752.mx.srv.dfn.de [194.95.239.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D6B38DF9
	for <linux-can@vger.kernel.org>; Sat, 27 Jul 2024 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.95.239.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722075912; cv=none; b=nD20n85UwOz4e7mS/0NE2RtuSAvBjSI2/d/uYj7rqkByKNTAr4kUIbRUw6E+aeg8N5NUHyaYsNgkKZ80XZ+/Yw8icGib7bg4oLggTjhoLhNBhL9yp7qCbFqwagZcMfWCns4AmLrNhV/mRziV9hgoGB+vJW/5NxKR0u1fEv133IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722075912; c=relaxed/simple;
	bh=2vZfgZm6WzvJ0x3njI3/ED1fdgECu5OilsHA9jJfQBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=enVJNbE0LZSxMqsnfM0XmAK4xvOUeQyLSFUD7B+B0CiialWmnA6GIwW118uHmYcf3ijvIZAvkweofb4cuDzMLAwssCeIn69toD2BjNfws+3ZeHlacejnNwuQK1jJnj5/pyRqPeEHqIs0r3t4q+0+fw8J3l7yBsbZR9ltAXZg5vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=st.oth-regensburg.de; spf=pass smtp.mailfrom=st.oth-regensburg.de; dkim=pass (2048-bit key) header.d=st.oth-regensburg.de header.i=@st.oth-regensburg.de header.b=ZFmvc7lk; arc=none smtp.client-ip=194.95.239.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=st.oth-regensburg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=st.oth-regensburg.de
Received: from mta01.hs-regensburg.de (mta01.hs-regensburg.de [194.95.104.11])
	by c2752.mx.srv.dfn.de (Postfix) with ESMTPS id EA5072A011E;
	Sat, 27 Jul 2024 12:17:04 +0200 (CEST)
Received: from E16S03.hs-regensburg.de (e16s03.hs-regensburg.de [IPv6:2001:638:a01:8013::93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client CN "E16S03", Issuer "E16S03" (not verified))
	by mta01.hs-regensburg.de (Postfix) with ESMTPS id 4WWLC43kWJzxqv;
	Sat, 27 Jul 2024 12:17:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=st.oth-regensburg.de; s=mta01-20211122; t=1722075424;
	bh=Fd8yD69zKDfAySxKnJQTD5QQ50AOcdK+qgaxWosoJvQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:From;
	b=ZFmvc7lk4LqDOYwF6scD0x3dq9sfZZyB54wqwMb6JjJVIMLDCwkAOtKdmgnxtVC80
	 /WrrBFzeVilvsr5/v1uQlFBVmzWidwNv6MfKxsq2on27QO5dQKNTo5inyK44D07LsP
	 fNpu5GiTnHTYyZvJITHirC14zTbqRNxfyCqvDRicgNtPFb3+SUK1dvgchdBYZLmszA
	 IGNjH19sYiCoC9ACPDTPC8V20XjyfU7+VJTjp3yxzET0rybHVLbcf7zxfFgTCq/dz4
	 INJqsmVvYyTaqfjknjtrhnwovasZ6eYxkBEzkMDAK6Emh0ZkmYO1K5IMpI6wkdkGPw
	 Cw3bBzkvLX08A==
Received: from [IPV6:2003:f7:1727:8a00:117f:4e55:f78e:bb0c]
 (2001:638:a01:8013::226) by E16S03.hs-regensburg.de (2001:638:a01:8013::93)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 27 Jul
 2024 12:17:03 +0200
Message-ID: <8b96193b-082e-4c7f-b8ba-666580aae3e6@st.oth-regensburg.de>
Date: Sat, 27 Jul 2024 12:16:45 +0200
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
Content-Language: en-US
From: Matthias Unterrainer <matthias.unterrainer@st.oth-regensburg.de>
In-Reply-To: <CAMZ6RqK00=EKvCR8XBW7Vre5tSxsrD41LuGObV_5e=hYOKdSSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: E16S03.hs-regensburg.de (2001:638:a01:8013::93) To
 E16S03.hs-regensburg.de (2001:638:a01:8013::93)

Hi Vincent,

apologies for the late reply.

On 07-07-2024 17:23, Vincent Mailhol wrote:
> Hi Matthias,
> 
> On Fri. 5 Jul. 2024 at 02:47, Matthias Unterrainer
> <matthias.unterrainer@st.oth-regensburg.de> wrote:
>> Hi Linux-CAN Community,
>>
>> my name is Matthias and I recently developed a kernel module during my Bachelor's thesis that allows for transferring CAN frames over IP networks, similar to userland tools like socketcand [0] or cannelloni [1].
>>
>> I wrote the thesis at dissecto GmbH [2], a german Startup that specializes in security diagnostics and analytics for embedded systems, primarily within the automotive industry.
>>
>> The idea behind the project is that dissecto has developed a hardware device that can be connected to a CAN bus and acts as an ethernet gateway to the bus. It is capable of capturing the CAN traffic along with the corresponding timestamps and send this data via UDP or it can receive CAN frames via UDP as well and pass them on to the CAN bus.
>> This allows for remote interaction with a CAN bus, as well as an accurate analyses of CAN traffic, as packets contain precise time stamps.
>>
>> An architectural design decision was to develop it as kernel module because of lower latencies and high throughput.
> 
> Question: did you consider Packet MMAP?
> 
>    https://docs.kernel.org/networking/packet_mmap.html
> 
> Most of the overhead comes from the syscall context switch between the
> user and kernel land and Packet MMAP is exactly designed to bypass
> this. Actually, a few months ago, I started to rewrite the can-utils's
> candump to use Packet MMAP, but I never finished it.

No, at the time I did not consider Packet MMAP. From my understanding 
Packet MMAP is used for userspace applications. But the module has to 
modify the timestamps of the CAN frames as they appear on the interface, 
which, as far as I know, is not possible from userspace.
Please correct me if I am mistaken, but because of that I do not think 
Packet MMAP or any userspace application for that matter could actually 
be used here.

>> For example, my measurements show that the average time it takes a CAN frame to get processed by the module is just about 1/4 of the time it takes applications like socketcand or cannelloni.
>>
>> We have published the module on GitHub [3], and would appreciate your feedback and thoughts.
>>
>> If anyone is interested in this functionality for the same or similar use cases, please don't hesitate to contact us.
>>
>> Best regards
>> Matthias Unterrainer
> 
> I "scrolled" through the code. Here are two quick feedbacks.

Thanks for the feedback. I already partly implemented your feedback and 
the rest will come soon.

> In struct can2eth_pkthdr:
> 
>> struct can2eth_pkthdr {
>>      u32 magic;
>>      u32 tv_sec;
>>      u32 tv_nsec;
>>      u16 seqno;
>>      u16 size;
>> };
> 
> If I understand correctly, these are big endian. In That case, use the
> __be16 and __be32 types (c.f.
> https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/types.h#L37).
> This will allow use to use sparse to check that all conversion are
> done correctly:
> 
>    https://www.kernel.org/doc/html/latest/dev-tools/sparse.html
> 
> Also, you added the description of each of struct can2eth_pkthdr's
> fields in the README.md. It is preferable to put it directly together
> with the code, using the kernel-doc style:
> 
>    https://docs.kernel.org/doc-guide/kernel-doc.html
> 
> 
> 
> In ctem_setup_communications():
> 
>> int ctem_setup_communications(struct ctem_comm_handler *handler, int src_port,
>>                    char **addrs, int num_addrs)
>> {
>>      struct sockaddr_in *addr;
>>      u32 ip;
>>      u16 port = 0;
>>      int ret;
>>      int i;
>>
>>      handler->dest_addrs = kmalloc(sizeof(struct sockaddr *), GFP_KERNEL);
>>      if (!handler->dest_addrs) {
>>          pr_err("Could not allocate destination addresses\n");
>>          return -ENOMEM;
>>      }
>>
>>      handler->last_seqno = 0;
>>      handler->num_addrs = 0;
>>
>>      /* parse input ip addresses */
>>      if (!num_addrs) {
>>          addr = kmalloc(sizeof(struct sockaddr_in), GFP_KERNEL);
>>          if (!addr) {
>>              pr_err("Could not allocate ip addr\n");
>>              return -ENOMEM;
>>          }
> 
> You are doing a memory allocation here...
> 
>>          addr->sin_family = PF_INET;
>>          addr->sin_port = htons(port);
>>          addr->sin_addr.s_addr = INADDR_ANY;
>>
>>          handler->dest_addrs[0] = (struct sockaddr *)addr;
>>
>>          handler->num_addrs = 1;
>>      } else {
>>          for (i = 0; i < num_addrs; i++) {
>>              ret = parse_ip_port(ip_addrs[i], &ip, &port);
>>              if (ret) {
>>                  pr_err("Invalid IP/port format: %s\n",
>>                         ip_addrs[i]);
>>              } else {
>>                  pr_debug("Parsed IP: %pI4, Port: %u\n", &ip,
>>                       port);
>>                  addr = kmalloc(sizeof(struct sockaddr_in),
>>                             GFP_KERNEL);
>>                  if (!addr) {
>>                      pr_err("Could not allocate ip addr\n");
>>                      return -ENOMEM;
>>                  }
>>
> 
> ... and here ...
> 
>>                  addr->sin_family = PF_INET;
>>                  addr->sin_port = htons(port);
>>                  addr->sin_addr.s_addr = ip;
>>
>>                  handler->dest_addrs[handler->num_addrs] =
>>                      (struct sockaddr *)addr;
>>                  handler->num_addrs++;
>>              }
>>          }
>>      }
>>
>>      ret = ctem_setup_udp(handler, src_port);
>>      if (ret)
>>          return ret;
>>
>>      ret = msgbuilder_init(handler);
>>      if (ret)
>>          return ret;
> 
> ... but here you directly return on those errors without freeing the
> previously allocated memory. Is this OK?
> 
> Overall, it will probably be simpler to move your
> 
>    /* parse input ip addresses */
> 
> if/else block in a separate helper function.
> 
>>      handler->reception_thread = kthread_create(
>>          ctem_reception_thread, handler, "ctem_reception_thread");
>>      if (IS_ERR(handler->reception_thread)) {
>>          pr_err("%s: Error creating reception thread\n", MODULE_NAME);
>>          return PTR_ERR(handler->reception_thread);
>>      }
>>
>>      return 0;
>> }
> 
>> [0] https://github.com/linux-can/socketcand
>> [1] https://github.com/mguentner/cannelloni
>> [2] https://dissec.to
>> [3] https://github.com/dissecto-GmbH/can2eth-kernel-module
> 
> Yours sincerely,
> Vincent Mailhol

Best regards,
Matthias Unterrainer

