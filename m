Return-Path: <linux-can+bounces-7326-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJd8Oyizzml+pQYAu9opvQ
	(envelope-from <linux-can+bounces-7326-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 20:19:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F97338D047
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 20:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF7A9304D275
	for <lists+linux-can@lfdr.de>; Thu,  2 Apr 2026 18:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C57225788;
	Thu,  2 Apr 2026 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FW/VWMeM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFPblSux"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AD0374756
	for <linux-can@vger.kernel.org>; Thu,  2 Apr 2026 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153594; cv=none; b=R2/r4Z+w4EvmG+978e93hEOEej32mYM37a2oX4QsbgTM8k7nn1vYrP593N0fD4/1gioCY4zjdw+gw1T9oRS+d7zYIh3AsyL3nuP89yTYD7nw9ZJOTH0OtdhLlC4s3PfiO6Ssk02eRCVctsMa1y1GfaSUdTWI8tqpPYE3eg9A7ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153594; c=relaxed/simple;
	bh=RmYULP9wScf/Xo+BG1i22buunc5mVC7MTO3A/GCN7EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5MWZfwjdfWvuAgk/IMBj+dBTiC/Exai9yp23diuLeUAcpc/hLocrgVxmNZrGrKbbMjwBhmK8i4MNTQIYrs50Jdt6J4JJscmB3OZp/qxA99oegagQkjFE04AcOImsoOUDIACPsSyKgAjgrIEOQPgIBCizK6nX2/7Res9WZftuNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FW/VWMeM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFPblSux; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775153592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/9Q7nePXkoICbJwnkSnqe6rVbqB3tJ6E01COqz94ojs=;
	b=FW/VWMeMSmrSwht/JnHasVLOkvWI3Q2MdipadFL+nfCb5K8vyMNkSPuvsxp5d+kjCZB3Wp
	R9zHJmtQREoaYimobGWaa00Az8KHkrnPjR5HBcqjTIJdWVX9vRu30H/trVMqsmSaWkyQTy
	/F+d0E7jSz8B9QkLFG8eH9VndcaqH+g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-szMLXUWHNSmWxvnLVzXuIg-1; Thu, 02 Apr 2026 14:13:11 -0400
X-MC-Unique: szMLXUWHNSmWxvnLVzXuIg-1
X-Mimecast-MFC-AGG-ID: szMLXUWHNSmWxvnLVzXuIg_1775153590
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so25190165e9.0
        for <linux-can@vger.kernel.org>; Thu, 02 Apr 2026 11:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775153590; x=1775758390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/9Q7nePXkoICbJwnkSnqe6rVbqB3tJ6E01COqz94ojs=;
        b=YFPblSuxCEW5D/Bt1XYgW7+GMFd7E2izPiyJwIb00zoivTHnUdmf76VAIXeY/lV31G
         AzBrnjbWXUUVA/u0xu6P4DILbm4hSpKhYaPLv4clzapfk6w0jaMgrmYMvHjwUNK++9qP
         K/OnZkB0AWmA9dDmhy5zw65/ySR4Iuz5/TGDhHmsb/OcOAty94DAYs7zJA+6Odvo/l/B
         TPG3g541cQJMABbBbWXwzgX6bpJ+/WBc8eiz4yzvEOIrR+aKAWjmfm9HKQ1yTG11+88K
         DxDsDKxXG9gXkr/EuVrb0bysB40WbjlGlhhmD7UAsbOr6q3S59mzzCbbqCvMJ91osz9W
         Pvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775153590; x=1775758390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9Q7nePXkoICbJwnkSnqe6rVbqB3tJ6E01COqz94ojs=;
        b=chtwMkAsL3vCSv8MA162rY8oBCsntO69qoWHTQhWXSXPt38Hw0jF5CychMDETagr7B
         VyASB1RJsPkmaxZUMZhuSDB+smzaVF8ynh1Bf3rr5MkI01XLqwPXjFQuo/CjIB8Je2kj
         FComwg50RDcYqMRC6giw4JHBiu1sTLjl0QT4J1gm4Q9T5jUAgiEBYaGmYKExwVNIkpyD
         iqW4qWSGajj8ihy8JN/AgG4gBRREyzy6d1x+F9Y3RRDdJbGM1JTSWBKBrhSsPSeNQFMZ
         7IY4uITyoaGyr0eWw/m0Oklj7l436MFcBPWVQS+UETg+u8sf7lySYeDfZqv2wuJkBnDR
         34JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIcASb6dohpARytrooUGs9LbxYdxpKKpbZD4Y2tBzYGrEByxsCBLIZ0ksFRCGvaVVlCVoghurVikw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEJJDHT8uCHbKV/iyQD0qYIR8UqCB3zzg1U6da40NxqpPFIwZZ
	iDZn16njw+Z3nC/K8x8K04OEGrYP10fNwdDYFGQPtJXpFmvyTmhTJWK4Xi2ldW5Pv8h9G1dMshK
	TXJEJ0pSVq5+TBKKw6rmJSWUrw85Jntl9N8FO2/bvBfY+nmhhg30D53BBvzzwQA==
X-Gm-Gg: ATEYQzxw/1SP8j2NvqbT4KpmyUJPYeoffhEnsLTQMEKuNHS1Yvt1y8ft8ciSqnxPgbB
	8uO5l5ATqEtgWHlx0TvOjG5SLmTSdLhPXRf6jw3OZYl8dSNCRbepiSKbFDGaloYPgCJ7OUX6EPr
	3XfDVtT+fymJ2SpH1x5i0P/dIx3oYHQXuuXOtgf9KKBiUfzIYUbr5AfBUUDdCLMXudH4ufPtQ0V
	6MglXlg6Yw7+tq2Pzbt2bObfFb2rHFI7IKosGfjm34jTK2Nbcxar+N/Qb73zVqkEttmb126SILs
	v4QF1XLKeoFM8biE/xlTBSWSYFAUQ3/RPjjFqlG2+6vkySSSDHUdI4wyoy4Gh6HBvsci8ZxORKJ
	5sCHLoCAdE0JMK1NjKt82Irsg1meZNrxgxVe0o/TcxGt9a44Z27bhKrGnodov
X-Received: by 2002:a05:600c:a30a:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-4889949bd2dmr1850815e9.11.1775153589656;
        Thu, 02 Apr 2026 11:13:09 -0700 (PDT)
X-Received: by 2002:a05:600c:a30a:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-4889949bd2dmr1850135e9.11.1775153588948;
        Thu, 02 Apr 2026 11:13:08 -0700 (PDT)
Received: from storniolo-redhat (net-2-34-60-62.cust.vodafonedsl.it. [2.34.60.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e832585sm392571815e9.6.2026.04.02.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 11:13:08 -0700 (PDT)
Date: Thu, 2 Apr 2026 20:13:06 +0200
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
Message-ID: <ac6xcEBq9E35JGdF@storniolo-redhat>
References: <20260402-feat-can-diag-v1-0-245b56434c1b@redhat.com>
 <20260402-feat-can-diag-v1-3-245b56434c1b@redhat.com>
 <ba4170ca-3e74-49f4-856f-dca130db05ad@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ba4170ca-3e74-49f4-856f-dca130db05ad@hartkopp.net>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7326-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fstornio@redhat.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F97338D047
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Oliver,
thank you for the review.

On Thu, Apr 02, 2026 at 03:07:53PM +0200, Oliver Hartkopp wrote:
>Hello Filippo,
>
>many thanks for your patches.
>
>I'm not yet convinced we would need this kind of interface as many
>features in ss(8) are only relevant for IP and not really for CAN.
>
>Btw. having an overview over PIDs and open sockets might be a nice
>informational feature.
>
>Some remarks at first sight:
>
>On 02.04.26 12:54, Filippo Storniolo wrote:
>>Add the can_diag interface for querying sockets from userspace.
>>ss(8) tool can use this interface to list open sockets.
>>
>>The userspace ABI is defined in <linux/can_diag.h> and includes
>
>I would suggest <linux/can/diag.h> to match the other CAN netlayer
>definitions and not bloat the include/linux directory once more.
>

I created the file can_diag.h because I saw that every other
diag header (e.g. inet, packet, vm_sock, unix, etc.) are all
located under /include/uapi/linux.
However, on the other hand, most of these do not have a directory
under /include/uapi/linux as can already has it.

>>netlink request and response structs.  The request queries open
>>can sockets and the response contains socket information fields
>>including the interface index for bound sockets, inode number,
>>transport protocol etc.
>>
>>Support can be added later by extending can_diag_dump().
>>
>>Suggested-by: Davide Caratti <dcaratti@redhat.com>
>>Signed-off-by: Filippo Storniolo <fstornio@redhat.com>
>>---
>>  MAINTAINERS                   |   1 +
>>  include/uapi/linux/can_diag.h |  43 ++++++++++++
>
>include/uapi/linux/can/diag.h
>

If needed, this will be changed accordingly.

>>  net/can/Kconfig               |  10 +++
>>  net/can/Makefile              |   2 +
>>  net/can/can-diag.c            | 153 ++++++++++++++++++++++++++++++++++++++++++
>
>net/can/diag.c
>
>for the same reason.
>

Agree, I will change the file from can_diag.c to diag.c

>>  5 files changed, 209 insertions(+)
>>
>>diff --git a/MAINTAINERS b/MAINTAINERS
>>index 7a2ffd9d37d57c0db59e602eeffc2e2f09b613d9..f338ef2380a634a671d06f27bb4dac6f45f4d2a4 100644
>>--- a/MAINTAINERS
>>+++ b/MAINTAINERS
>>@@ -5730,6 +5730,7 @@ F:      include/linux/can/skb.h
>>  F:  include/net/can.h
>>  F:  include/net/netns/can.h
>>  F:  include/uapi/linux/can.h
>>+F:   include/uapi/linux/can_diag.h
>>  F:  include/uapi/linux/can/bcm.h
>>  F:  include/uapi/linux/can/gw.h
>>  F:  include/uapi/linux/can/isotp.h
>>diff --git a/include/uapi/linux/can_diag.h b/include/uapi/linux/can_diag.h
>>new file mode 100644
>>index 0000000000000000000000000000000000000000..e63d79f1ab3803a5778407e07d485732a112745a
>>--- /dev/null
>>+++ b/include/uapi/linux/can_diag.h
>>@@ -0,0 +1,43 @@
>>+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>+
>>+#ifndef _UAPI__CAN_DIAG_H__
>
>Why not using _UAPI_CAN_DIAG_H_ here?
>

No particular reason, we can change it to _UAPI_CAN_DIAG_H_

>>+#define _UAPI__CAN_DIAG_H__
>>+
>>+#include <linux/types.h>
>>+#include <linux/can.h>
>>+
>>+/* Request */
>>+struct can_diag_req {
>>+     __u8    sdiag_family;   /* must be AF_CAN */
>>+     __u8    sdiag_protocol; /* for future filtering of transport protocols */
>>+     __u16   pad;
>>+     __u32   cdiag_states;
>>+     __u32   cdiag_ino;
>>+     __u32   cdiag_show;
>>+     __u32   cdiag_cookie[2];
>>+};
>>+
>>+enum {
>>+     CAN_DIAG_UNSPEC,
>>+     CAN_DIAG_UID,
>>+
>>+     __CAN_DIAG_MAX,
>>+};
>>+
>>+#define CAN_DIAG_MAX (__CAN_DIAG_MAX - 1)
>>+
>>+/* Response */
>>+struct can_diag_msg {
>>+     __u8    cdiag_family;   /* AF_CAN */
>>+     __u8    cdiag_state;
>>+     __u16   cdiag_protocol;
>>+     __u16   cdiag_type;
>>+     __u16   pad16;
>>+     __u32   cdiag_ino;
>>+     canid_t cdiag_tx_id; /* meaningful only for ISO-TP */
>>+     canid_t cdiag_rx_id; /* meaningful only for ISO-TP */
>
>What about the J1939 addressing here which is part of the struct
>sockaddr_can too?
>

Right, I missed this during implementation. I guess we can either
extend the structure so that it contains also the addressing
information of J1939 or add a new attribyte in the netlink message,
similar to what it has been done for the uid.

IMHO, I think the second option is better, especially when
we dump information that are valid only for specific protocols.
Otherwise, we would have a bigger netlink message for every socket,
even if they do not need some fields.

However, we can evaluate pros and cons and refine it.

>>+     __s32   cdiag_ifindex;
>>+     __u32   cdiag_cookie[2];
>>+};
>>+
>>+#endif /* _UAPI__CAN_DIAG_H__ */

Regards,
Filippo


