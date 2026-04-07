Return-Path: <linux-can+bounces-7341-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHBfHSXC1GmWwwcAu9opvQ
	(envelope-from <linux-can+bounces-7341-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Apr 2026 10:36:53 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6F13AB6D4
	for <lists+linux-can@lfdr.de>; Tue, 07 Apr 2026 10:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7958E300463F
	for <lists+linux-can@lfdr.de>; Tue,  7 Apr 2026 08:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30290399009;
	Tue,  7 Apr 2026 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3nA6HAw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s22u7UT3"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3CA398903
	for <linux-can@vger.kernel.org>; Tue,  7 Apr 2026 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551008; cv=none; b=BZCVCzmxDt+2iKXfHT0dU6LfrDbnDdxr0Ges9mjahQ1Sy8SgxU8qXald2FO5ZZwBbfQISEnc9lqOJSbpdjcmOSg/acxzgTtWwNWOBGwH4AiLR2bkzT9+XeGli01H5+76sa2wEAWn6j7fRRpzB0g3sWRnCl9x4P+gkR9BrcIO7mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551008; c=relaxed/simple;
	bh=541yCyudfl/Oig6i683jbZpLPIiYIjuPsLEPZltlbGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mojXbS1SWCIMkAWVWMLhCQY1rcwH7nqgfj+XGZUo2gquubYJRXoos0XloxB/X+0n9+WrTNX34tqbSEb0TmbuMTtdSBQVtC/6/uQJtzUreth63YhLtCmd7esGomsY70f0GMLjg+IwRa+gf56sWermrk9J6G7/df95hfcc2c4PpKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3nA6HAw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s22u7UT3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775551001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXjJmisGLe9c1EBjfdUUR813+mIV6drownEtZ9rlEOc=;
	b=O3nA6HAwDQRZetWVZE5i9f57nUbYJueEJMxt1rdHLlUL7bbPbTJV2A8alc7h4e+Bcd546Z
	SujvyjY6wu5fMUcIgyhqx1YkJ0ROgtd6J+QQNcvjFDOMy7PFsSPcqqdzgPslr1h5VCwX2y
	T5VjjQsmgKx7VkhEX9FP61bm7fht2TM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-yp1DPX5-Pp-A4dtYCVjjnQ-1; Tue, 07 Apr 2026 04:36:40 -0400
X-MC-Unique: yp1DPX5-Pp-A4dtYCVjjnQ-1
X-Mimecast-MFC-AGG-ID: yp1DPX5-Pp-A4dtYCVjjnQ_1775550999
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488a6c8650aso9689395e9.3
        for <linux-can@vger.kernel.org>; Tue, 07 Apr 2026 01:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775550999; x=1776155799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JXjJmisGLe9c1EBjfdUUR813+mIV6drownEtZ9rlEOc=;
        b=s22u7UT3Z9cs6u1ihTKiJRZfrgi8/0OksGjuLplTXbJCVzn0fbv85PPICVyqH9ikkQ
         8DyIE/E9hOHivdh28o5y/hI+ZNxtMcbo2hiZCQUnD/OtuET1OpLQKtH/hcfHurKTbIwl
         UkoMbVvIDLuzhiLOeOUe70IS/wMkcRT9ANv0ZjoMq/NNZb6STwfLxsh9hUHUEV8tD6O4
         Oi3f+8fxpBl8OcIIzKv9l8UxtLxYCF4LCrtwYPOl3u54t74813fKfhx/IB9xD1jYxGK8
         fQ79r7S4pXHfsxutkoLTpR0TT4FVjdmFJ7o8qWi2XoKhQBlJJJKqd9n00u999IKzz+Wt
         J98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550999; x=1776155799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXjJmisGLe9c1EBjfdUUR813+mIV6drownEtZ9rlEOc=;
        b=CeYwv3Em5X2O5i+4W+UndkD4htqQuPNtEJBPmvV3RfvjdYi6I1hoxcU+PAvBOtxyIY
         sOorZaunFp2sZCJAx8Of7EUf6xozaQcmubWFNPJcH0k6Bp6FC546EAemgk5bUagibAF1
         pv3bx4IlD94Cn+/hu/V2JJlXKryz7UxV0XHiqPdR2dCNg5OVLf+/yq3UKhXUCB0P6Nzw
         QzQ1qQiikjAoIF8r31A5RGd+7FSuR/OyOzRxNKM2+y+GDxMOtChbVOzFu5KTveAzDKH3
         Wj/mzOUGDb+XqhKy2HxoQbts5BdHxLLGHik/gZqj7rkSr6y994XUPceYmvSdlPyITShx
         8yCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ92uq4SQR4mxRoABySS0o5xKBMsghCaMvjV3OGbHQzIB2aJy5R9RWQLdZVN+1y7YbNVmK2vOD7kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmQR3dFERfhrDlYmYEDR7JLJ3KT3PBnxffXXgyy0yTrwtGAKFQ
	h1y6Wvt5JwfGpwGy/8l/7Og+VCa5eXo1yVhFKa5cxqsEjbNKuv8c9z3tqwL2w6fSrAEPvXJaNkW
	vu1X0gqEHafgDrzElK3k9TOd2wHuBBoQEdiA2auoiUSXAVjc0JxsRjkyZjNSPBg==
X-Gm-Gg: AeBDieuZaeljzngH/9tpTe/TPbb7G1XsUs+fRz/DPeVIRDOUTCBumLISHZ/GGrSwio5
	cA1NhIMMNr409kGKVh+BEMP2uHX2zdX0oEQraXMuqZN8esitO+BuH6CftRGaGiSfTJoQz6xeDJ4
	X1BP9K0tOK2HGx3Bjl84EcbXh4+cZNT9YIYRb1Y+5Bh4SaUR6xVFactIXssptrZcXjayMtikYVf
	/GXLeBbHkDYHTYMXTOiABvavNXtnbJyCNL62bpgpG/OK+rncCfuwcLMCbhubBAEvza3eUqqvXBY
	BPGAPBJltFjc/RKFHpwcAspByU6ox78Yi2QO/WL3UYBYsZx+gI+QODPis11Gz9sDPB+7W1jNYcS
	JaL7DBssCfUdeJWY=
X-Received: by 2002:a05:600c:314d:b0:488:bc6a:5285 with SMTP id 5b1f17b1804b1-488bc6a538bmr27314025e9.30.1775550999338;
        Tue, 07 Apr 2026 01:36:39 -0700 (PDT)
X-Received: by 2002:a05:600c:314d:b0:488:bc6a:5285 with SMTP id 5b1f17b1804b1-488bc6a538bmr27313505e9.30.1775550998854;
        Tue, 07 Apr 2026 01:36:38 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488be75215dsm36969965e9.6.2026.04.07.01.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:36:38 -0700 (PDT)
Date: Tue, 7 Apr 2026 10:36:36 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Dorinda Bassey <dbassey@redhat.com>
Cc: virtualization@lists.linux.dev, linux-can@vger.kernel.org,
	harald.mommer@oss.qualcomm.com, mkl@pengutronix.de,
	mailhol@kernel.org, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	mikhail.golubev-ciuchea@oss.qualcomm.com, sgarzare@redhat.com,
	francesco@valla.it
Subject: Re: [PATCH v13] can: virtio: Add virtio CAN driver
Message-ID: <adTCFHpT6AThJT5L@fedora>
References: <acLNB9PYmJ9L0Wvc@fedora>
 <20260402095243.647258-1-dbassey@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402095243.647258-1-dbassey@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7341-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mvaralar@redhat.com,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1A6F13AB6D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 11:52:43AM +0200, Dorinda Bassey wrote:
> Hi Matias,
> 
> I've been testing PATCH v13 of the virtio CAN driver and encountered a
> FORTIFY_SOURCE panic when transmitting frames:
> 
> 	sh-5.3# cansend can0 123#DEADBEEF                                                                                     
> 	[   51.700501] Kernel BUG at __fortify_panic+0x9/0xb [verbose debug info unavailable]                                 
> 	[   51.700798] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI                                                      
> 	[   51.700881] CPU: 2 UID: 0 PID: 374 Comm: cansend Tainted: G        W          6.12.76 #1                           
> 	[   51.701070] Tainted: [W]=WARN                                                                                      
> 	[   51.701143] RIP: 0010:__fortify_panic+0x9/0xb                                                                      
> 	[   51.701212] Code: 01 00 00 e9 58 7e c2 ff cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90  
> 	90 40 0f b6 ff e8 57 a9 c2 ff <0f> 0b 48 8b 54 24 08 48 8b 74 24 10 4c 8d 44 24 1d 4c 89 e1 48 c7                     
> 	[   51.701406] RSP: 0018:ffffc900001ffb10 EFLAGS: 00010246                                                            
> 	[   51.701454] RAX: 0000000000000000 RBX: ffff888100ea8780 RCX: 0000000000000003                                      
> 	[   51.701530] RDX: 0000000000000000 RSI: ffffc900001ff9b8 RDI: 0000000000000001                                      
> 	[   51.701625] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000fffffbff                                      
> 	[   51.701700] R10: ffffffff82239ee0 R11: ffffc900001ff9b0 R12: ffff888100ea8000                                      
> 	[   51.701789] R13: ffff888100817200 R14: ffff88810037cda0 R15: ffffc900001ffb48                                      
> 	[   51.701866] FS:  00007f7c4cda3740(0000) GS:ffff88812bd00000(0000) knlGS:0000000000000000                           
> 	[   51.701948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033                                                      
> 	[   51.702007] CR2: 00007f7c4ceffdc0 CR3: 0000000100d12000 CR4: 0000000000350eb0                                      
> 	[   51.702072] Call Trace:                                                                                            
> 	[   51.702105]  <TASK>                                                                                                
> 	[   51.702126]  ? virtio_can_start_xmit.cold+0x2b/0x4d                                                                
> 	[   51.702171]  ? srso_alias_return_thunk+0x5/0xfbef5 
> 
> The issue is in virtio_can_start_xmit() where can_tx_msg->tx_out.length
> is set AFTER memcpy(can_tx_msg->tx_out.sdu, ...). Since sdu[] uses
> __counted_by_le(length), FORTIFY_SOURCE sees length=0 during the copy
> and panics.
> 
> The fix is to set length before the memcpy:
> 
Thanks I just pick it for v14! I did not observe this behavior before. I
guess they added a new validation that I was not aware of.

Matias

> diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
> index xxx..yyy 100644
> --- a/drivers/net/can/virtio_can.c
> +++ b/drivers/net/can/virtio_can.c
> @@ -308,6 +308,7 @@ static netdev_tx_t virtio_can_start_xmit(struct sk_buff *skb,
>  
>  	can_tx_msg->tx_out.msg_type = cpu_to_le16(VIRTIO_CAN_TX);
> +	can_tx_msg->tx_out.length = cpu_to_le16(cf->len);
>  	can_flags = 0;
>  
>  	if (cf->can_id & CAN_EFF_FLAG) {
> @@ -322,7 +323,6 @@ static netdev_tx_t virtio_can_start_xmit(struct sk_buff *skb,
>  		can_flags |= VIRTIO_CAN_FLAGS_FD;
>  
>  	can_tx_msg->tx_out.flags = cpu_to_le32(can_flags);
> -	can_tx_msg->tx_out.length = cpu_to_le16(cf->len);
>  
>  	sg_init_one(&sg_out, &can_tx_msg->tx_out, hdr_size + cf->len);
> 
> Tested with vhost-device-can backend, and it works correctly after this fix.
> 
> Thanks,
> Dorinda Bassey
> 


