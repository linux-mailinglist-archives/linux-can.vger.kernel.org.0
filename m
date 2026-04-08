Return-Path: <linux-can+bounces-7351-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JckDWmI1mmwFwgAu9opvQ
	(envelope-from <linux-can+bounces-7351-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Apr 2026 18:55:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AF73BF28C
	for <lists+linux-can@lfdr.de>; Wed, 08 Apr 2026 18:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 615C0300405B
	for <lists+linux-can@lfdr.de>; Wed,  8 Apr 2026 16:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BBF351C04;
	Wed,  8 Apr 2026 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sr7//CYU";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="W7SLX/sV"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95113D47B3
	for <linux-can@vger.kernel.org>; Wed,  8 Apr 2026 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667289; cv=pass; b=ib/4GbxA2Q1KzBMIMWMnY/q6wYhM0/OJhtgEFPfxY2tk8UhiU0deloOanAKdr3fulBP7XhPDErmU3olOIxnlSypw5GlsFwXf/R58QEF9OpcLKrm6zcwFJCYaAgX9qy8bKuZ1cxPrjA3pc52TimcrsA7XhFK57okrcZPnlPxLoA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667289; c=relaxed/simple;
	bh=WbiJR0QX8kP9ZDnPzXYK23WXHbWy2+laKvte0asyPIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAL1b2xwK5lgwMYcqRD45dEMaASQP6hmI/XxUaytSFpsmInIeb/LhKaoW/apqID6k3NQrr6cq4W4S/+7i/5rS7ubfvy7ojIC33l6d65/38wSUZcO5K5xS9Cc/dZ/weZDCj6pGqnsvx/srEIon6CEjQpz6zFLKNrtbK0rlFYfU0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sr7//CYU; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=W7SLX/sV; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1775667277; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=i2AAhV1UZ94clpOZoYxwacSE7ZUun+BJp3lS54KSWZzQDSxMJFk4+rmwEYICXhpkFy
    PmvQZ4gb63XISvyGnjZCi2q172gUJjkNkv5MJxtd8Z2iWJnDXNuJTYb2ZSbhuQNRcDOF
    ll0EO3Wc85wFNe03FoI3BaYcNT2wARDZE2kjogpP52+DzvKULgw6cADY/9GzvsYnyRTS
    A1NJHedXT4kBuD1QkExQINiSebH0eHjQH1CPpqaj+q3krnZOz79KdkjWPO5LthH1xniu
    8NAQd9Wngmzld4up6xF/J3bOLSQgiO6HTMPZPqDHGHGkOiccCrdj8QT6OhjFd8iJ36kn
    fA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1775667277;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=knUb6arcw/1ctGmYg0+mgOGBC8l35Dz9BTou7RC5GmE=;
    b=NiBjyimyUgq7aU11dSSG5p7wXe2nHArq9PbTx02fR0VLZ24d3s6dUJ97zLxs5I12Lr
    IoAexYZNkl1m9ov6s9W5C0DRceJ5gxxwovZuUvEHp38ZOD6LZTG7exqiNuJZg37v5//3
    4uuXCvpYPaaM5EEmwINwdfB4Qn8+jCjeGtctNTkyh6xVmJxqPsslDBQsjFf1hBN76+nY
    ODA9fVz+yvOOaBP4mbTmeW10L7DTOotQgAEhYDA9iLxR8StkCWaJEAi+oIDAGAiEbxGW
    3awZ+nM/yZVEMpt6WkXuwLSi+LlpMXOFjFnqKN6ocLGS5SvZvvAcxm0KyqJuoYZnwFZF
    mOrQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1775667277;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=knUb6arcw/1ctGmYg0+mgOGBC8l35Dz9BTou7RC5GmE=;
    b=sr7//CYUK3yHEm4c6/t9jS7v9WLFKljJZlhpjLPUXeUtV4KblAs0piG1QYVWd+rfuZ
    G28BUBDE1/hDTx+34zDRL0qQ2s/cj+j3M56yf3TNbY850/GDgS3D5yj04of73voxK0PB
    C8gOshxZaYocxtZQ3e9+hkHlFoNnIvvCisPi+5nEZCcdqaaWTrWAoQTBKdBUDgXoVo18
    uKmsrPT9Kwx31EVRnzyl3xFCcjGYZ67KuaEVGOoJ1OfA4viv1PCtTcrvw8jJLiIfBeCb
    SVS9Ka7K1YVXm3U/nLJl5dVu+40oWKZPU5xg5L9G+qIs4Yh/OmMNWtSfRBN9ANa5K04l
    7UGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1775667277;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=knUb6arcw/1ctGmYg0+mgOGBC8l35Dz9BTou7RC5GmE=;
    b=W7SLX/sV+H6gBmaTp+YyAgxD53jAXhu9lXBMJYnnO6rq6vWVJngrt4tNd3kBb1AQ2T
    PUO6MqPuusXkoj9f6oDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTRsLs5FrPm8xWJP2FLGj7g=="
Received: from [192.168.1.104]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d238GsbuDZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 8 Apr 2026 18:54:37 +0200 (CEST)
Message-ID: <5e34096c-85af-4db3-a69e-cbbbc17068da@hartkopp.net>
Date: Wed, 8 Apr 2026 18:54:31 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC can-next 3/3] can: add can diag interface
To: Filippo Storniolo <fstornio@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 "David S. Miller" <davem@davemloft.net>,
 Urs Thuermann <urs.thuermann@volkswagen.de>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-can@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
 Radu Rendec <rrendec@redhat.com>, Davide Caratti <dcaratti@redhat.com>
References: <20260402-feat-can-diag-v1-0-245b56434c1b@redhat.com>
 <20260402-feat-can-diag-v1-3-245b56434c1b@redhat.com>
 <ba4170ca-3e74-49f4-856f-dca130db05ad@hartkopp.net>
 <ac6xcEBq9E35JGdF@storniolo-redhat>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <ac6xcEBq9E35JGdF@storniolo-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7351-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hartkopp.net:dkim,hartkopp.net:mid]
X-Rspamd-Queue-Id: 35AF73BF28C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 02.04.26 20:13, Filippo Storniolo wrote:
> Hi Oliver,
> thank you for the review.
> 
> On Thu, Apr 02, 2026 at 03:07:53PM +0200, Oliver Hartkopp wrote:
>> Hello Filippo,
>>
>> many thanks for your patches.
>>
>> I'm not yet convinced we would need this kind of interface as many
>> features in ss(8) are only relevant for IP and not really for CAN.
>>
>> Btw. having an overview over PIDs and open sockets might be a nice
>> informational feature.
>>
>> Some remarks at first sight:
>>
>> On 02.04.26 12:54, Filippo Storniolo wrote:
>>> Add the can_diag interface for querying sockets from userspace.
>>> ss(8) tool can use this interface to list open sockets.
>>>
>>> The userspace ABI is defined in <linux/can_diag.h> and includes
>>
>> I would suggest <linux/can/diag.h> to match the other CAN netlayer
>> definitions and not bloat the include/linux directory once more.
>>
> 
> I created the file can_diag.h because I saw that every other
> diag header (e.g. inet, packet, vm_sock, unix, etc.) are all
> located under /include/uapi/linux.
> However, on the other hand, most of these do not have a directory
> under /include/uapi/linux as can already has it.

Thanks

> 
>>> netlink request and response structs.  The request queries open
>>> can sockets and the response contains socket information fields
>>> including the interface index for bound sockets, inode number,
>>> transport protocol etc.
>>>
>>> Support can be added later by extending can_diag_dump().
>>>
>>> Suggested-by: Davide Caratti <dcaratti@redhat.com>
>>> Signed-off-by: Filippo Storniolo <fstornio@redhat.com>
>>> ---
>>>  MAINTAINERS                   |   1 +
>>>  include/uapi/linux/can_diag.h |  43 ++++++++++++
>>
>> include/uapi/linux/can/diag.h
>>
> 
> If needed, this will be changed accordingly.
> 
>>>  net/can/Kconfig               |  10 +++
>>>  net/can/Makefile              |   2 +
>>>  net/can/can-diag.c            | 153 ++++++++++++++++++++++++++++++++ 
>>> ++++++++++
>>
>> net/can/diag.c
>>
>> for the same reason.
>>
> 
> Agree, I will change the file from can_diag.c to diag.c

Thanks!

>>>  5 files changed, 209 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 
>>> 7a2ffd9d37d57c0db59e602eeffc2e2f09b613d9..f338ef2380a634a671d06f27bb4dac6f45f4d2a4 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -5730,6 +5730,7 @@ F:      include/linux/can/skb.h
>>>  F:  include/net/can.h
>>>  F:  include/net/netns/can.h
>>>  F:  include/uapi/linux/can.h
>>> +F:   include/uapi/linux/can_diag.h
>>>  F:  include/uapi/linux/can/bcm.h
>>>  F:  include/uapi/linux/can/gw.h
>>>  F:  include/uapi/linux/can/isotp.h
>>> diff --git a/include/uapi/linux/can_diag.h b/include/uapi/linux/ 
>>> can_diag.h
>>> new file mode 100644
>>> index 
>>> 0000000000000000000000000000000000000000..e63d79f1ab3803a5778407e07d485732a112745a
>>> --- /dev/null
>>> +++ b/include/uapi/linux/can_diag.h
>>> @@ -0,0 +1,43 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>> +
>>> +#ifndef _UAPI__CAN_DIAG_H__
>>
>> Why not using _UAPI_CAN_DIAG_H_ here?
>>
> 
> No particular reason, we can change it to _UAPI_CAN_DIAG_H_
> 

Thanks!

>>> +#define _UAPI__CAN_DIAG_H__
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/can.h>
>>> +
>>> +/* Request */
>>> +struct can_diag_req {
>>> +     __u8    sdiag_family;   /* must be AF_CAN */
>>> +     __u8    sdiag_protocol; /* for future filtering of transport 
>>> protocols */
>>> +     __u16   pad;
>>> +     __u32   cdiag_states;
>>> +     __u32   cdiag_ino;
>>> +     __u32   cdiag_show;
>>> +     __u32   cdiag_cookie[2];
>>> +};
>>> +
>>> +enum {
>>> +     CAN_DIAG_UNSPEC,
>>> +     CAN_DIAG_UID,
>>> +
>>> +     __CAN_DIAG_MAX,
>>> +};
>>> +
>>> +#define CAN_DIAG_MAX (__CAN_DIAG_MAX - 1)
>>> +
>>> +/* Response */
>>> +struct can_diag_msg {
>>> +     __u8    cdiag_family;   /* AF_CAN */
>>> +     __u8    cdiag_state;
>>> +     __u16   cdiag_protocol;
>>> +     __u16   cdiag_type;
>>> +     __u16   pad16;
>>> +     __u32   cdiag_ino;
>>> +     canid_t cdiag_tx_id; /* meaningful only for ISO-TP */
>>> +     canid_t cdiag_rx_id; /* meaningful only for ISO-TP */
>>
>> What about the J1939 addressing here which is part of the struct
>> sockaddr_can too?
>>
> 
> Right, I missed this during implementation. I guess we can either
> extend the structure so that it contains also the addressing
> information of J1939 or add a new attribyte in the netlink message,
> similar to what it has been done for the uid.
> 
> IMHO, I think the second option is better, especially when
> we dump information that are valid only for specific protocols.
> Otherwise, we would have a bigger netlink message for every socket,
> even if they do not need some fields.
> 
> However, we can evaluate pros and cons and refine it.

In sockaddr_can the ISO-TP and J1939 address information is placed in an 
union as they can not be valid at the same time and the cdiag_protocol 
also provides the information what kind of content we would have read, 
right?

Best regards,
Oliver


