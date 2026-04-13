Return-Path: <linux-can+bounces-7367-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKAjBU4w3WlAagkAu9opvQ
	(envelope-from <linux-can+bounces-7367-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 13 Apr 2026 20:05:02 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 797283F1CB3
	for <lists+linux-can@lfdr.de>; Mon, 13 Apr 2026 20:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 408B9301DC05
	for <lists+linux-can@lfdr.de>; Mon, 13 Apr 2026 18:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA2917BB21;
	Mon, 13 Apr 2026 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZR7T7Mwa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ey7VwP2G"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF2923E325
	for <linux-can@vger.kernel.org>; Mon, 13 Apr 2026 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103498; cv=none; b=SO+lYf6pc0qB8ZK56UEN1oUjPqLluNdNCCV0Q2BivvtBeQGHq8Khc46yYDNn0vRUqM/pGfcRAOQSKeTL0Wjzj/uAoEKutI3F9IdEUheseac9Fqd4jfhqu+UAQav1QjFuL1v7t6lHh6pw0uftnbWzKvl3dZpJpH3EY9XrDXgP0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103498; c=relaxed/simple;
	bh=ZrhNqEj9FGJXKjcAT6edEVrzzuqF/mvw+RJ79f09yDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hr9rr9tCMJhzTJorkIQDZ0CqPjK0rqNIi0goVp9Bq/W0eb6tkeT7xNrbJudWgPjzqAJeUr8M5oo4Hb12pdABjHBg5nakVOiJbORLfiLvjd01s3PmoAYpE7tu1TcHC0mHSX98ACLHuCPkJeoBek5/N7tv4qZem5c6WFfpDqCBKUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZR7T7Mwa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ey7VwP2G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776103495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shLoOMTEHAEHiZDhTCkik/MHN11wSgYoDmcGSCUNt1o=;
	b=ZR7T7Mwas5LQvq/a+1x9mgdDG3wIn+I6SbcK5Z1UAPylBxoKkY4eF9fA1BflppgBn8T2ep
	FKvSi3QoTQPUMDPRLT4Un7kIXg2HJ/JH01Ctoufp1mfCXzOcv8UB6WAYEdYlqiW5s/rVKv
	oBO2UptrDljCGxYXiSsJYNFi4eVUa7I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-lAWOCRHDMzat1oM09zoMQA-1; Mon, 13 Apr 2026 14:04:54 -0400
X-MC-Unique: lAWOCRHDMzat1oM09zoMQA-1
X-Mimecast-MFC-AGG-ID: lAWOCRHDMzat1oM09zoMQA_1776103493
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488e12db7e0so16832475e9.3
        for <linux-can@vger.kernel.org>; Mon, 13 Apr 2026 11:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776103493; x=1776708293; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=shLoOMTEHAEHiZDhTCkik/MHN11wSgYoDmcGSCUNt1o=;
        b=Ey7VwP2GqjXCD0r3P1JqMkWwCOqTcD6E2gmj2SVnAPaPEry8DTwqCZ7YLeREPLYASU
         Hduu2IsAq3+dEWZGdZDog306wygxf1LsG+Yjew1sSZ8Gmw538VPn4JjnY1CULSrrXGu7
         RIx9eX8TRBbKoosSVOhLuCGYVNwlOB52bG84hf7XnXeQ/w9cOTjqVjqUWNfyh9iyYZj3
         Ksq+7hUHXXpvIqtHzD+9TU/sMeN/WO+UU3tuAoun6yZYGSAQ5JUOz0QMaL6ioVswXqB6
         RToe4R7TtarUd21XssBSkCLmZHEzij5hiosJBPuENYs1vc+YtO+tFU2bdEdonblMGzSi
         ZORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776103493; x=1776708293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shLoOMTEHAEHiZDhTCkik/MHN11wSgYoDmcGSCUNt1o=;
        b=e/8fiyJY9nfSMLZUFCgAZ9lZaH+a2zOkw+V6IxrXAVBz6oZYkh6eSEcnlgv+tdkPF4
         I19JFOSDW69ybpmoomnYxPA7yxFJFED7pbne857P/ZSp+xqZgHtqbTmHoxm+Rem4FuJK
         mMwVdUa11sqee67R69i8oO0KJStGlv1yEqRBmS8QZ2KNTPcFmgKLFoYoizagCmJ/0fMf
         qEE7J5QVdWWgfwQxdhHOG4iZbfYZnUPkRaHKo7MWD5Nmcu+m5CpHgM2Ek53UVfez78Z6
         MJ7zCisZKiTciwa/rwsdNmITQDxRFJJsrnPWJGTrnAm/r9N555uZCxWDBWwBhraPqka2
         izWA==
X-Forwarded-Encrypted: i=1; AFNElJ9wWLE0TpykbuJEPDBhLWSkml1uVrKR0JCRiZxToRLwpbEPxB8EA+3ee9RYfcsIaND2+DqQf9j5yzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI9taNXBk/wXnTa5mlbUQB0MulHea0iDlsxJirTyQbOjusUtQv
	oubnu3K2NYnl7iQlRxCCsv7gjX+yN62dKE7b3ql8teSw9pPxXZHCn/FPidPQA16N2SIbe+S1gL7
	4NDIDLhxc80vKv/N6lm8hhZH7R2t8zWHnf70iyPyBAwxZOPe8hGwhwAS+e99nsg==
X-Gm-Gg: AeBDiesPfIoikfExhRsc29mMgaP3JOmKK4uRljpL39QCDOR2qGhd1065+/qNff++SIJ
	ndjkp9bWZAyOku10uRmSYMC6lxtLXkIq6BAq2cq8z8A+NJEpYF+eE+0KK131SSE9gAbAjnKjO+6
	Z0HZNtb5SJGX+cLPBn0RK3Bz/GfQU77VLINzJff9OoZsQ/RAaO5LafpyQ2pwuOBSMKptwU6+01C
	9ZSNW9qVRs2Gh+Q2AJQ/td2+/rJK3V2zwFP1WNffPSTAmbBmYOArK/tg9Y23S/crKcZ0YXV7Ie1
	MyhlFKRy8ifgp0t2XKgM+yG5iWWfYd0WbqYJtlKT6N9xafNKytehGAdjy9EU1VeXauXARmFhQVh
	1kivfrbRq/Ax+tkebblIrFcwscuodYZtXw7GX8WX3BKWtbUef82WDE8KtH8VX
X-Received: by 2002:a05:600c:4709:b0:488:ae6c:42c0 with SMTP id 5b1f17b1804b1-488d67d2ab2mr168574035e9.7.1776103493245;
        Mon, 13 Apr 2026 11:04:53 -0700 (PDT)
X-Received: by 2002:a05:600c:4709:b0:488:ae6c:42c0 with SMTP id 5b1f17b1804b1-488d67d2ab2mr168573705e9.7.1776103492734;
        Mon, 13 Apr 2026 11:04:52 -0700 (PDT)
Received: from storniolo-redhat (net-2-34-60-62.cust.vodafonedsl.it. [2.34.60.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b46ffsm137535295e9.6.2026.04.13.11.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 11:04:51 -0700 (PDT)
Date: Mon, 13 Apr 2026 20:04:49 +0200
From: Filippo Storniolo <fstornio@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	"David S. Miller" <davem@davemloft.net>, Urs Thuermann <urs.thuermann@volkswagen.de>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
	Stefano Garzarella <sgarzare@redhat.com>, Radu Rendec <rrendec@redhat.com>, 
	Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH RFC can-next 3/3] can: add can diag interface
Message-ID: <ad0pIPrN77tBmXIr@storniolo-redhat>
References: <20260402-feat-can-diag-v1-0-245b56434c1b@redhat.com>
 <20260402-feat-can-diag-v1-3-245b56434c1b@redhat.com>
 <ba4170ca-3e74-49f4-856f-dca130db05ad@hartkopp.net>
 <ac6xcEBq9E35JGdF@storniolo-redhat>
 <5e34096c-85af-4db3-a69e-cbbbc17068da@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e34096c-85af-4db3-a69e-cbbbc17068da@hartkopp.net>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7367-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fstornio@redhat.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 797283F1CB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 06:54:31PM +0200, Oliver Hartkopp wrote:

Hi Oliver,

>>>>+/* Response */
>>>>+struct can_diag_msg {
>>>>+     __u8    cdiag_family;   /* AF_CAN */
>>>>+     __u8    cdiag_state;
>>>>+     __u16   cdiag_protocol;
>>>>+     __u16   cdiag_type;
>>>>+     __u16   pad16;
>>>>+     __u32   cdiag_ino;
>>>>+     canid_t cdiag_tx_id; /* meaningful only for ISO-TP */
>>>>+     canid_t cdiag_rx_id; /* meaningful only for ISO-TP */
>>>
>>>What about the J1939 addressing here which is part of the struct
>>>sockaddr_can too?
>>>
>>
>>Right, I missed this during implementation. I guess we can either
>>extend the structure so that it contains also the addressing
>>information of J1939 or add a new attribyte in the netlink message,
>>similar to what it has been done for the uid.
>>
>>IMHO, I think the second option is better, especially when
>>we dump information that are valid only for specific protocols.
>>Otherwise, we would have a bigger netlink message for every socket,
>>even if they do not need some fields.
>>
>>However, we can evaluate pros and cons and refine it.
>
>In sockaddr_can the ISO-TP and J1939 address information is placed in 
>an union as they can not be valid at the same time and the 
>cdiag_protocol also provides the information what kind of content we 
>would have read, right?
>

Yes, you are right. To be more specific, my idea is to have the
can_diag_msg struct like the following:

/* Response */
struct can_diag_msg {
	__u8	cdiag_family;	/* AF_CAN */
	__u8	cdiag_state;
	__u16	cdiag_protocol;
	__u16	cdiag_type;
	__u16	pad16;
	__u32	cdiag_ino;
	__s32	cdiag_ifindex;
	__u32	cdiag_cookie[2];
};

and then add the following structures in the uapi:

struct can_diag_isotp_id {
	canid_t tx_id;
	canid_t rx_id;
};

struct can_diag_j1939_id {
	__u64	name;
	__u32	pgn;
	__u8	addr;
};

By defining two new attributes for j1939 and isotp,
we can fill the netlink response like this:

struct can_diag_isotp_id isotp_id; 
isotp_id.tx_id = can_addr.can_addr.tp.tx_id;
isotp_id.rx_id = can_addr.can_addr.tp.rx_id;

rep->cdiag_rx_id = can_addr.can_addr.tp.rx_id;
if (sk->sk_protocol == CAN_ISOTP) {
	nla_put(skb, CAN_DIAG_ISOTP_ID, sizeof(can_diag_isotp_id), &isotp_id);
}

and same for j1939.

This is useful because we don't have any un-needed fields
in the can_diag_msg structure, but we can still provide to the
userspace information relevant only for specific protocols.

Cheers,
Filippo


