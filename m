Return-Path: <linux-can+bounces-7368-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L9hNyrk3WnDkwkAu9opvQ
	(envelope-from <linux-can+bounces-7368-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Apr 2026 08:52:26 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 819D63F6466
	for <lists+linux-can@lfdr.de>; Tue, 14 Apr 2026 08:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E270300AC8D
	for <lists+linux-can@lfdr.de>; Tue, 14 Apr 2026 06:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E64A340260;
	Tue, 14 Apr 2026 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="p9usZQef";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="CNSMJ7AH"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E68A340DAB
	for <linux-can@vger.kernel.org>; Tue, 14 Apr 2026 06:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776149544; cv=pass; b=K0ej1iPHAKSoXxFEfRjxXSKV3MCrdFdhqY242W8qUCxpzM2b99O0K0wN32MTC4RhJDGn4Q1iiHuBX7ocJ7mCQUUsAy46HQf+jVuNN/IybASqF1390xx+UDjimR6k28fSUCK5Ne2rsVqPAF8R16FguyA4zmyxrFL9tAVHUZXS5bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776149544; c=relaxed/simple;
	bh=Qf53bj5M09Qt+xYXMUoSTHXxZEteN1dQh0z7S55r8/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIAhbS4by/8LwO90J/k4kIJK0rDcElKCZPaJdIOIQk5dlWxqxIuonAf78/7Xa5F/QHLavBNqr8Qd8DfLBO0xJLFrIsxZTd+veg+SEXEhSz54cBU6EOuSvtUm4qen1Z5gwDPePoOjwJgbMiGklTpi9UZVZ5noaHrCBEQ81tbwuJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=p9usZQef; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=CNSMJ7AH; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1776149533; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=efLDd2kuLhJw3N3PMqje2x2iB7MHcSYoCK3q64clSpAHvmX+tQvRRLPF19g3WZuIUl
    PH0SmCBi/akzZOru8bwFy4j4+6Gfv3ILa4cNEe/ICyZzSeZ5iof39w5PrYDlDOkKbPVT
    WBiqkB8/ISybLO7TXym/4cdLeJfWGcD3ozXEuE60o6Beqy4QBrduakKitVWRaUnSiC5P
    8cE+qgmwEt3hE04lMsU5tUvZBLtltLvaWNBEWZ5nvp4pcLlbvmQiXKt4cfFFmfaoROI7
    kU7wIpTn0v6gHCH3wz5hlD13ih/EadVNh8W5iGIXvO2XlvJM6Fcgn8NhfpRH4/5jkjMr
    ONng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1776149533;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=enjyPao/do52E6m9DdLHLVvJnJRHMBtw/09qGN+KD64=;
    b=E8NS+WtLmowyPMW9fSi1frE7Vd8AMflewbWKSjavOXMVKwGddnZqjHp1GpcoE9yuRJ
    mAHfcTrUVCa3k/WvBBzmrNrrwCvg9srm16aF9GLNrUgQZRLsGxrJRX4uWIVYn6KusJfb
    Mx5Sm/eApl/xArxHzKTKuvMQLQzCSKN8UjA3yMh+djBzkAhaX73EP+1ntnAs+UgTYF7o
    22ah/vUpHx97aXebVXNHeL5vkyK/A/Rr4N0dKgk4jJ/3CXRISkRug3JcVHD4sDMoIP1h
    U9n5ywC1rIUq4hSoW8bLbONf9b+QjpBh84BSb+sEn7CtJR9OTr16SJAnzLNnKTye4mKm
    GErw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1776149533;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=enjyPao/do52E6m9DdLHLVvJnJRHMBtw/09qGN+KD64=;
    b=p9usZQefOi9QDTJOmIfHr9QeL7wJXH/1nKWodwO83svrzODkzrhzWtAJKIazvWKni7
    e/TSgEi1sg24nY0sddpxl016i0CTdxCRCsMiOLMrceQ0W0K36uLj9nAWV4uyr3h+o48A
    HdBPt7grzCuIiTrSFEtiIRBNwYZp+O5AcrSGkoFJEmcyPYvWNx+5H5a+WoSFL7GLrGeR
    aFIW5XCXpZ4+TsQpT12c/8mynfYunJg5Sf7fOfH3CuAflYzriKLLgUJ7wEBlx4iHXbC8
    HFMBLzxns40iT5R4nBrldRyb7CmTMh1QWpMGz3X83nm6bQn9jJDFqM6UWRPv42dTKpku
    vfMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1776149533;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=enjyPao/do52E6m9DdLHLVvJnJRHMBtw/09qGN+KD64=;
    b=CNSMJ7AHMjXQUVgV3h63gJu+lzf8m8CcbwB1D6//pkeKTUX4TeXf4IuJlKzDweXQxr
    snMJUlh6R36di7RwORAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8YjX10Q=="
Received: from [IPV6:2a00:6020:4a38:6800::76e]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d23E6qCASC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 14 Apr 2026 08:52:12 +0200 (CEST)
Message-ID: <dec91f0d-a104-4d94-bec8-d70c391bd6f8@hartkopp.net>
Date: Tue, 14 Apr 2026 08:52:06 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC can-next 3/3] can: add can diag interface
To: Filippo Storniolo <fstornio@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
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
 <5e34096c-85af-4db3-a69e-cbbbc17068da@hartkopp.net>
 <ad0pIPrN77tBmXIr@storniolo-redhat>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <ad0pIPrN77tBmXIr@storniolo-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7368-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 819D63F6466
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 13.04.26 20:04, Filippo Storniolo wrote:
> On Wed, Apr 08, 2026 at 06:54:31PM +0200, Oliver Hartkopp wrote:

>>
>> In sockaddr_can the ISO-TP and J1939 address information is placed in 
>> an union as they can not be valid at the same time and the 
>> cdiag_protocol also provides the information what kind of content we 
>> would have read, right?
>>
> 
> Yes, you are right. To be more specific, my idea is to have the
> can_diag_msg struct like the following:
> 
> /* Response */
> struct can_diag_msg {
>      __u8    cdiag_family;    /* AF_CAN */
>      __u8    cdiag_state;
>      __u16    cdiag_protocol;
>      __u16    cdiag_type;
>      __u16    pad16;
>      __u32    cdiag_ino;
>      __s32    cdiag_ifindex;
>      __u32    cdiag_cookie[2];
> };
> 
> and then add the following structures in the uapi:
> 
> struct can_diag_isotp_id {
>      canid_t tx_id;
>      canid_t rx_id;
> };
> 
> struct can_diag_j1939_id {
>      __u64    name;
>      __u32    pgn;
>      __u8    addr;
> };
> 
> By defining two new attributes for j1939 and isotp,
> we can fill the netlink response like this:
> 
> struct can_diag_isotp_id isotp_id; isotp_id.tx_id = 
> can_addr.can_addr.tp.tx_id;
> isotp_id.rx_id = can_addr.can_addr.tp.rx_id;
> 
> rep->cdiag_rx_id = can_addr.can_addr.tp.rx_id;
> if (sk->sk_protocol == CAN_ISOTP) {
>      nla_put(skb, CAN_DIAG_ISOTP_ID, sizeof(can_diag_isotp_id), &isotp_id);
> }
> 
> and same for j1939.
> 
> This is useful because we don't have any un-needed fields
> in the can_diag_msg structure, but we can still provide to the
> userspace information relevant only for specific protocols.

Ok, got it.

Btw. either for ISO-TP and for J1939 these values are address definitions.

So the structs should be named

struct can_diag_isotp_addr {
      canid_t tx_id;
      canid_t rx_id;
};

struct can_diag_j1939_addr {
      __u64    name;
      __u32    pgn;
      __u8    addr;
};

@Oleksij: Does that fit for you too?

Best regards,
Oliver

