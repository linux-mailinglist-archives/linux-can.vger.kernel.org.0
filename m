Return-Path: <linux-can+bounces-7324-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIXvAxFuzmnxngYAu9opvQ
	(envelope-from <linux-can+bounces-7324-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 15:24:33 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64339389A33
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 15:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 251593033D0A
	for <lists+linux-can@lfdr.de>; Thu,  2 Apr 2026 13:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01763CEB87;
	Thu,  2 Apr 2026 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="NQ8PieMP";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="S3njDjUV"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1654341AC7
	for <linux-can@vger.kernel.org>; Thu,  2 Apr 2026 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135477; cv=pass; b=WrP0B1z9ZbQH2qJgJ/d5jyMeLlZcoyV1AUqhvtgYPrdKurVNsXQ+CA8j+5NNzFzMw7ro7x9dxD1BzLeWFz2TZIYNuEdLLzmr+PKsAXE6HDwxIMdTtMAiLMtJCfijUuHpwrXFVvlc2tDQ1UhedRwSmN7V57+UAbr79WDoUrY9LNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135477; c=relaxed/simple;
	bh=iH8LV4RCDky78X5eWXeUjL07MTjGujnNwdeqIzy925U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enqLDkkAy15mXueA7p0pm8L34/pkrK8pN5pHzVEXe6iK7wCx0aC1toBsXbOXErwyNyPOvXCbqtgAI7D0/9OhySyfexJv24ekWwJbGd0iMsd5JQpqxpVHExet3RsJI16pyD5Wcw17tDczCXfNjnQFvE4PVBmZVRRQq2rcw5b2hcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=NQ8PieMP; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=S3njDjUV; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1775135279; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Y4WISioVre73xHomIw+zvbTNPuiQPoLw+8kky+Hf5ihzaCvf/Ib4kCsbNjWWPl38ls
    WWWVQXRjDZJenhBz+7W9t9tCDt0be+RcPoegYeN4jmJu2uYGBn6WpejOti/KvlnOgyZU
    PGvbgkqsVG+KqzHGMdQgXRKHtpmlJyHtuRta+ZBLOx+spTT9VboPgSK8oly8XpBBM++V
    K9RSQ6A0ieJBZq6+X3+XdNeDFxmUxOMP84xYcf+gXEvJI2Un7NZf9S37RekX9Fr47b9b
    5FxTwLzXGpllRO0IM25heTap+zOL/rLxRlcf4ZAIFA+ZxrC+xTH57EvHuAHTL5J3ujmb
    5XBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1775135279;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HCYJBWq5ysVzfKrKuGysKG+gUzFoqClptfOq5FekKSI=;
    b=T31Mte4wynXxXrg61nnwRat6XvbHSGSdWHkYZNWNkGX1JeayWmf4AkJb3U6CPjzLvp
    SFareCiK/TrFsuHioCad13EvrHij5R8EWgd+keSnzeYMBEZkHV2rS9dlAH1Gn1TldRyD
    LvsMl1suwSOMKD2tPxUHsGLireiPXU/DP2ijxl6HqpRvhvAXrbb+zP8/TuqcQG/2FT86
    JWAQqqvXxcp6+xgpYnlDcK5BsVtbsit8dr1CD86xaQzY0mos6wYZr/udbSJz3vIWSCJK
    gDYfiRh8qMyOXnvc0GIDl63ZUFZCvHr0ZeOFCW6F9r2iljI4vOaJr82PkZ5klpyS4nlg
    Ma5w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1775135279;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HCYJBWq5ysVzfKrKuGysKG+gUzFoqClptfOq5FekKSI=;
    b=NQ8PieMPJM5z414VI9cCskkd2TGTauQcitxUkqZIVTRr7B/SUZN1wwXc37aQJo4tZ5
    LSmXS2uthR9KcT7qeAndq1YLH6Mu9AJpTNmvVge/7X0qKUBPWIYiNiCKFe62Wh2ZJiOF
    GycFLwBl0bFt4+k9yl68dlVd6iR/XFE8MhrpmoArLnF1DE4/Xo5WN+xmvPQT23l5EzX7
    w5E+qWiFM4+3ZnEnDK8kCd7O3but76aGZHDI23bVuzZaA6izBX6c/4oUnZjXP3VJPapF
    d5gZQVLMaYcGQ/FDB6FhzSyAvdmG/8OGDdQgNvOlu3zXd5mB27HXYmDF0T8FNw4+P/hr
    fOJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1775135279;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HCYJBWq5ysVzfKrKuGysKG+gUzFoqClptfOq5FekKSI=;
    b=S3njDjUVpDfzpM1gj738KDh6bOH0Bdltew3jhTCSrRoaJOaSItHGuS72ZyM0QsgDa8
    3n20xoA9VbCz4foNP1Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7tnZzaltqKDqzOtwjWhW4zc0PyAYA=="
Received: from [IPV6:2a00:6020:4a38:6810:a255:a92f:6917:94c8]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d232D7xf5L
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 2 Apr 2026 15:07:59 +0200 (CEST)
Message-ID: <ba4170ca-3e74-49f4-856f-dca130db05ad@hartkopp.net>
Date: Thu, 2 Apr 2026 15:07:53 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC can-next 3/3] can: add can diag interface
To: Filippo Storniolo <fstornio@redhat.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 "David S. Miller" <davem@davemloft.net>,
 Urs Thuermann <urs.thuermann@volkswagen.de>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
 Radu Rendec <rrendec@redhat.com>, Davide Caratti <dcaratti@redhat.com>
References: <20260402-feat-can-diag-v1-0-245b56434c1b@redhat.com>
 <20260402-feat-can-diag-v1-3-245b56434c1b@redhat.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260402-feat-can-diag-v1-3-245b56434c1b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7324-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:dkim,hartkopp.net:mid]
X-Rspamd-Queue-Id: 64339389A33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Filippo,

many thanks for your patches.

I'm not yet convinced we would need this kind of interface as many 
features in ss(8) are only relevant for IP and not really for CAN.

Btw. having an overview over PIDs and open sockets might be a nice 
informational feature.

Some remarks at first sight:

On 02.04.26 12:54, Filippo Storniolo wrote:
> Add the can_diag interface for querying sockets from userspace.
> ss(8) tool can use this interface to list open sockets.
> 
> The userspace ABI is defined in <linux/can_diag.h> and includes

I would suggest <linux/can/diag.h> to match the other CAN netlayer 
definitions and not bloat the include/linux directory once more.

> netlink request and response structs.  The request queries open
> can sockets and the response contains socket information fields
> including the interface index for bound sockets, inode number,
> transport protocol etc.
> 
> Support can be added later by extending can_diag_dump().
> 
> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Signed-off-by: Filippo Storniolo <fstornio@redhat.com>
> ---
>   MAINTAINERS                   |   1 +
>   include/uapi/linux/can_diag.h |  43 ++++++++++++

include/uapi/linux/can/diag.h

>   net/can/Kconfig               |  10 +++
>   net/can/Makefile              |   2 +
>   net/can/can-diag.c            | 153 ++++++++++++++++++++++++++++++++++++++++++

net/can/diag.c

for the same reason.

>   5 files changed, 209 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a2ffd9d37d57c0db59e602eeffc2e2f09b613d9..f338ef2380a634a671d06f27bb4dac6f45f4d2a4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5730,6 +5730,7 @@ F:	include/linux/can/skb.h
>   F:	include/net/can.h
>   F:	include/net/netns/can.h
>   F:	include/uapi/linux/can.h
> +F:	include/uapi/linux/can_diag.h
>   F:	include/uapi/linux/can/bcm.h
>   F:	include/uapi/linux/can/gw.h
>   F:	include/uapi/linux/can/isotp.h
> diff --git a/include/uapi/linux/can_diag.h b/include/uapi/linux/can_diag.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..e63d79f1ab3803a5778407e07d485732a112745a
> --- /dev/null
> +++ b/include/uapi/linux/can_diag.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +
> +#ifndef _UAPI__CAN_DIAG_H__

Why not using _UAPI_CAN_DIAG_H_ here?

> +#define _UAPI__CAN_DIAG_H__
> +
> +#include <linux/types.h>
> +#include <linux/can.h>
> +
> +/* Request */
> +struct can_diag_req {
> +	__u8	sdiag_family;	/* must be AF_CAN */
> +	__u8	sdiag_protocol; /* for future filtering of transport protocols */
> +	__u16	pad;
> +	__u32	cdiag_states;
> +	__u32	cdiag_ino;
> +	__u32	cdiag_show;
> +	__u32	cdiag_cookie[2];
> +};
> +
> +enum {
> +	CAN_DIAG_UNSPEC,
> +	CAN_DIAG_UID,
> +
> +	__CAN_DIAG_MAX,
> +};
> +
> +#define CAN_DIAG_MAX (__CAN_DIAG_MAX - 1)
> +
> +/* Response */
> +struct can_diag_msg {
> +	__u8	cdiag_family;	/* AF_CAN */
> +	__u8	cdiag_state;
> +	__u16	cdiag_protocol;
> +	__u16	cdiag_type;
> +	__u16	pad16;
> +	__u32	cdiag_ino;
> +	canid_t cdiag_tx_id; /* meaningful only for ISO-TP */
> +	canid_t cdiag_rx_id; /* meaningful only for ISO-TP */

What about the J1939 addressing here which is part of the struct 
sockaddr_can too?

> +	__s32	cdiag_ifindex;
> +	__u32	cdiag_cookie[2];
> +};
> +
> +#endif /* _UAPI__CAN_DIAG_H__ */
> diff --git a/net/can/Kconfig b/net/can/Kconfig
> index abbb4be7ad2152c66abd2e28dbbd5282ec45d065..ed210d62da7c28798d2f6f1967739e1621093cbf 100644
> --- a/net/can/Kconfig
> +++ b/net/can/Kconfig
> @@ -70,4 +70,14 @@ config CAN_ISOTP
>   	  as needed e.g. for vehicle diagnosis (UDS, ISO 14229) or IP-over-CAN
>   	  traffic.
>   
> +config CAN_DIAG
> +	tristate "CAN socket monitoring interface"
> +	depends on CAN
> +	default m
> +	help
> +	  Support for CAN socket monitoring interface used by the ss tool.
> +	  If unsure, say Y.
> +
> +	  Enable this module so userspace applications can query open sockets.
> +
>   endif
> diff --git a/net/can/Makefile b/net/can/Makefile
> index 58f2c31c1ef377ef8c5385211e7182d42ac2225a..76a3247aa97c982b864914f7aaa3a5b0e96a2e82 100644
> --- a/net/can/Makefile
> +++ b/net/can/Makefile
> @@ -20,3 +20,5 @@ obj-$(CONFIG_CAN_J1939)	+= j1939/
>   
>   obj-$(CONFIG_CAN_ISOTP)	+= can-isotp.o
>   can-isotp-y		:= isotp.o
> +
> +obj-$(CONFIG_CAN_DIAG) += can-diag.o

can-diag.ko is a good name indeed.

Best regards,
Oliver

> diff --git a/net/can/can-diag.c b/net/can/can-diag.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..77e1fe66e4a6513ff640d0c19c688dcd2e3970ee
> --- /dev/null
> +++ b/net/can/can-diag.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *
> + * Copyright (C) 2026 Red Hat
> + * Author: Filippo Storniolo <fstornio@redhat.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/net.h>
> +#include <net/netlink.h>
> +#include <linux/sock_diag.h>
> +#include <linux/can.h>
> +#include <linux/can_diag.h>
> +#include <net/net_namespace.h>
> +#include <net/sock.h>
> +#include <linux/netdevice.h>
> +#include <linux/percpu.h>
> +#include <linux/user_namespace.h>
> +
> +static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
> +			struct can_diag_req *req,
> +			struct user_namespace *user_ns,
> +			u32 portid, u32 seq, u32 flags, int sk_ino)
> +{
> +	struct sockaddr_can can_addr;
> +	struct can_diag_msg *rep;
> +	struct nlmsghdr *nlh;
> +	uid_t uid;
> +	int err;
> +
> +	nlh = nlmsg_put(skb, portid, seq, SOCK_DIAG_BY_FAMILY, sizeof(*rep), flags);
> +	if (!nlh)
> +		return -EMSGSIZE;
> +
> +	rep = nlmsg_data(nlh);
> +	memset(rep, 0, sizeof(struct can_diag_msg));
> +
> +	rep->cdiag_family = AF_CAN;
> +	rep->cdiag_type = sk->sk_type;
> +	rep->cdiag_ino = sk_ino;
> +	rep->cdiag_protocol = sk->sk_protocol;
> +	rep->cdiag_state = READ_ONCE(sk->sk_state);
> +	sock_diag_save_cookie(sk, rep->cdiag_cookie);
> +
> +	uid = from_kuid_munged(user_ns, sk_uid(sk));
> +	err = nla_put(skb, CAN_DIAG_UID, sizeof(uid_t), &uid);
> +	if (err < 0) {
> +		nlmsg_cancel(skb, nlh);
> +		return err;
> +	}
> +
> +	memset(&can_addr, 0, sizeof(can_addr));
> +
> +	err = kernel_getsockname(sk->sk_socket, (struct sockaddr *)&can_addr);
> +	if (err < 0) {
> +		/* Some protocols (e.g. CAN_BCM) do not implement kernel_getsockname().
> +		 * No error returned because the netlink message is still valid.
> +		 */
> +		if (err == -EOPNOTSUPP)
> +			goto exit_no_err;
> +
> +		nlmsg_cancel(skb, nlh);
> +		return err;
> +	}
> +
> +	rep->cdiag_ifindex = can_addr.can_ifindex;
> +
> +	if (sk->sk_protocol == CAN_ISOTP) {
> +		rep->cdiag_tx_id = can_addr.can_addr.tp.tx_id;
> +		rep->cdiag_rx_id = can_addr.can_addr.tp.rx_id;
> +	}
> +
> +exit_no_err:
> +	nlmsg_end(skb, nlh);
> +	return 0;
> +}
> +
> +static int can_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	int num = 0, s_num = cb->args[0];
> +	struct can_diag_req *req;
> +	struct net *net;
> +	struct sock *sk;
> +
> +	net = sock_net(skb->sk);
> +	req = nlmsg_data(cb->nlh);
> +
> +	mutex_lock(&net->can.sklist_lock);
> +	sk_for_each(sk, &net->can.sklist) {
> +		if (num < s_num)
> +			goto next;
> +
> +		if (sk_diag_fill(sk, skb, req,
> +				 sk_user_ns(NETLINK_CB(cb->skb).sk),
> +				 NETLINK_CB(cb->skb).portid,
> +				 cb->nlh->nlmsg_seq, NLM_F_MULTI,
> +				 sock_i_ino(sk)) < 0)
> +			goto done;
> +next:
> +		num++;
> +	}
> +done:
> +	mutex_unlock(&net->can.sklist_lock);
> +	cb->args[0] = num;
> +
> +	return skb->len;
> +}
> +
> +static int can_diag_handler_dump(struct sk_buff *skb, struct nlmsghdr *h)
> +{
> +	int hdrlen = sizeof(struct can_diag_req);
> +	struct net *net = sock_net(skb->sk);
> +	struct can_diag_req *req;
> +
> +	if (nlmsg_len(h) < hdrlen)
> +		return -EINVAL;
> +
> +	req = nlmsg_data(h);
> +	if (req->sdiag_protocol)
> +		return -EINVAL;
> +
> +	if (h->nlmsg_flags & NLM_F_DUMP) {
> +		struct netlink_dump_control c = {
> +			.dump = can_diag_dump
> +		};
> +		return netlink_dump_start(net->diag_nlsk, skb, h, &c);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct sock_diag_handler can_diag_handler = {
> +	.owner = THIS_MODULE,
> +	.family = AF_CAN,
> +	.dump = can_diag_handler_dump,
> +};
> +
> +static int __init can_diag_init(void)
> +{
> +	pr_info("can: diagnostic module\n");
> +	return sock_diag_register(&can_diag_handler);
> +}
> +
> +static void __exit can_diag_exit(void)
> +{
> +	sock_diag_unregister(&can_diag_handler);
> +}
> +
> +module_init(can_diag_init);
> +module_exit(can_diag_exit);
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("CAN socket monitoring via SOCK_DIAG");
> 


