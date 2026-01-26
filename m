Return-Path: <linux-can+bounces-6308-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOLwJ2tId2ledwEAu9opvQ
	(envelope-from <linux-can+bounces-6308-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 26 Jan 2026 11:56:43 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA35875C5
	for <lists+linux-can@lfdr.de>; Mon, 26 Jan 2026 11:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0B753029207
	for <lists+linux-can@lfdr.de>; Mon, 26 Jan 2026 10:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AB332AAA2;
	Mon, 26 Jan 2026 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="OaK3WOkt";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="haCjbWIq"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D303433373B
	for <linux-can@vger.kernel.org>; Mon, 26 Jan 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424477; cv=pass; b=CMJYEubadNjHrSuWQCEiTG3UmVWU+ealDPL9TUEI6iesszNCuTmecbez7yqp/mAIryWUq+mud4SXzsNKqJNbYW1u1aIhaZ+58+Qfw3UXm8P/AOlNZNq1sXs1cPjZZx15ruqIOfvvIN2xu1HQiKFEzNlovBn8J3bcY4ImZzF7ThM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424477; c=relaxed/simple;
	bh=lzjEcauHwwda489pxvKdr11AxGFNemyEBL0gs2H/6do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYrz01bG5MQwpgrxhsQGh8L56D02QpfdTHUzbSJpLL59EqY+Vbkrc2+Ugc2Qa81Xwi4bZBIpg5RIGhGQH/KRxc10rJ4zC15JPOWoKAPdLICoTp0zKg7oCYWOhsVAdf/nVjDjhwujLC/9dPsggoUQStXtFmhtxHQIND87Di1ZylY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=OaK3WOkt; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=haCjbWIq; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769424474; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nQx4UndGVI0FX0po2eVjki+4QPs46cHbAunaU7gSW4sA79IrxsO43AnnKXtmxAxOR2
    wGqgkfJCnqFw56tdRtn3zt4sR1yB1OrXjx9S4fJ57XvsZtAWdjydYlLGElLq0zOaVgRE
    7npZbzq5JQkeJ0fd+kLpBWtAV2O2R5hw3F8Le3P1M+s3Nz+ajW9k3Aneu/Jvrtx96X4n
    VRO6l3zBesdfGQL1iMgaABu5iP5CLjVW+nRbfkJpTo0ZIoSDBYNXthJEH95FiEs7LWMv
    cCHHZpyUljyRlyQn13AQgaXJo8tvWor6KkBiCy9NmUzDP91tK/5KDU71sivAnIsHHgeE
    j/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769424474;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UTAyntwWWH8THJuWnvUVMD071TFwrcWipA1yeCM51R4=;
    b=dIaBmVHx5iqDgxoLe3tgVx/qOnAvnHV0DO0yJq77tRSec+3JUjuTzTSSJNniyKLdXN
    g6TwxhP8JBnQ9SehvOYSqlM+25tgwkPYekDfTLRr//zIV5BDNoCnW06Da4uA0kW0/srY
    tsDw53h5avyCl9iYRjgoMgFNlDw0Sn39CXN0huMdj5roaBe9TFC1l9BMJ7pHy9BsWgtc
    N4j+XL/0Yv51YQTcrUvjY3wjiJldoojQGrzNNWHVg4K6x9beUFGNSblTbt20RzTcleUj
    Tk7dFXetnOQJ2TcrM+9l0VgfwDmvtytL//m/ZB0+BiGbapbb2oLj2HPH7J7LkpKcKuoO
    18UA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769424474;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UTAyntwWWH8THJuWnvUVMD071TFwrcWipA1yeCM51R4=;
    b=OaK3WOkt11OUn/ksC4O1HDtKxht5sxDcPTx10VwgETBSo/zQjKssY++evCFfM/5ldp
    wh2fmQx1mO/GQSFfeueQCLznfTUNvo34UOxgN6OgOQ2VIJLBvN0XRQ7bS+BjBltWJyYc
    /elLwJ6lcIyigXQYpy5/aN2yUMgkJZ+V+if6AaqdXYOqYRjUx/YHhHRTdwj5FiC4y0o/
    oMWvFrNKzo+S3TFX6V5s/2BT57dRRu7XkApCVx3Nemeti4FprnHhuKSUNeKtbUo6Hwm6
    ++uUf3HVdDenRN3Rqr8Qw4CiK9YZ5AbOMQNbcg8c9gayVPk4Po5gV+9UcLq3JjnZ2EZZ
    FPNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769424474;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UTAyntwWWH8THJuWnvUVMD071TFwrcWipA1yeCM51R4=;
    b=haCjbWIqJICwqUlp/R546a77fT2Bo+DNrmAuD+jngwWy+zb/cA3ugiwK/NlIUHDn1d
    DDmePEuuiMDY4oUuuaDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s1YTqptmo87qzm6sElmZEI+VN6rw=="
Received: from [IPV6:2a00:6020:4a38:6800:3499:34c0:1f42:76da]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20QAlrbWZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Jan 2026 11:47:53 +0100 (CET)
Message-ID: <da84a195-b138-45bd-abf1-223761ab3d24@hartkopp.net>
Date: Mon, 26 Jan 2026 11:47:48 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dummy_can: fix packet statistics
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org
References: <20260124211704.16430-1-socketcan@hartkopp.net>
 <4abee297-26e9-48f3-8ec6-2d99ba1f1839@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <4abee297-26e9-48f3-8ec6-2d99ba1f1839@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6308-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:mid,hartkopp.net:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CAA35875C5
X-Rspamd-Action: no action



On 25.01.26 20:31, Vincent Mailhol wrote:
> Hi Oliver,
> 
> On 24/01/2026 at 22:17, Oliver Hartkopp wrote:
>> The former implementation was only counting the tx_packets value.
>> Adopt the skb handling from vcan.c to correctly count the statistics
>> and fix the packet flow for looped packets.
> 
> My intent was to have the dummy_can's xmit() behave like the other
> hardware interface: just have the echo skb. I am not sure why a real
> vcan-style loop back would be needed here.
> 
> That also means that dummy_can would never be able to receive a packet,
> but I do not see the issue with that.
> 
>> The CAN echo support (IFF_ECHO) is enabled in dummy_can_init() to provide
>> a more realistic behaviour of real CAN hardware interfaces.
> 
> Ack. The IFF_ECHO is needed, otherwise the echo skb is discarded right
> away and the tx_bytes are never increased. Actually, this is not the
> only driver which forget to set up its IFF_ECHO flag.
> 
> So, for me, the fix would be to just add the IFF_ECHO. After doing just
> this locally, the statistics behave the same as with my real hardware
> interfaces: when I send a packet only the TX stats are increased and the
> RX stats remains unchanged.

Correct!

I've sent a v2 patch.
Thanks for the review!

Best regards,
Oliver


