Return-Path: <linux-can+bounces-7609-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK4SMtxsA2rF5gEAu9opvQ
	(envelope-from <linux-can+bounces-7609-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 20:09:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 486CC526E71
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 20:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 379E230F1F26
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 17:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFD63EDE5F;
	Tue, 12 May 2026 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jf1S4Yn0";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iDS6AZ1q"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F27E3EDE43;
	Tue, 12 May 2026 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608737; cv=pass; b=HXCVvc07cuTTUC2KR6WkIFu0FZ3eXwcT5lqd+rcsDdsv8hRh9zIOf8hEQzCp+qbNUbUubwl/LoxbfklZ+a7apf8oQDlCE8GWkt1uA199m61hAbrD6w7euCZ3b//tocr4Ge1JRg9LNPJSg90k/yKYdSSjRhxtZLgCs1vbpQdznAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608737; c=relaxed/simple;
	bh=LuWjQC3FMkJO1Hwt/21qYeebUBWG1s00qbsVpbstKHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csnUOa6hWkJDET6gFVivC+6RTqr2bGLj8d6CnMBgmouoGC65GQrdz1nvnV6NCk3CI59qf4/8PP4LUlWY8yVu//uXWUAYBCmbBs9nrFerXEUOweWOYLmOD5GfAG75moTAX0r4ooDAxrF5iF4uR71AJVcIyE0PQVaUiHooknPJfRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jf1S4Yn0; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iDS6AZ1q; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1778608725; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=euj2I7FE5cUIBij3X8zLEcJdS5EzPd0OwvA9iaWRFzQTGByzXTYflBhhUxvF3jhfgk
    mRNmtEMG1dkIsxREG6ubFmaTBorDNeF6n0E8ZiLyr10surK0tQTcyXwiZDdwkFbNSU6U
    B/ocWzLN6zN2awjRdHeaQLTQWjtqI+MUHXuk20VlFWHPNdLjwEWIM64w97MEUfp3O6g6
    clbC5LBIeoYQiPdJO47KxbDrI1L0dYtQlR2C6UiPU27QIUzhfknvl9PDzlmB28R1XhS5
    r7Vu5Ms7o0lf5fS5c8QzaGoQSpYlTrJ5lJUfQWGflxsJWHpDekVfC9WVJsAcyCTUED6n
    sdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1778608725;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=NSy4R6P/pT+6aAniX5R1PvRqKxggzdyZqdZ+72neo/g=;
    b=UW14pYKrpYjIUaWm3SALW3lLZruSevsvCLHyLSTCZMj1Ucg+nHBQHviKuvkKYb2W+7
    Q4P4A43I+98Rjyjh8YzG3U6IbaJicFviyIC8aZcSG7MJ2slsw/BI1uVDeLkY8fyfpApb
    trE0MKXqbx4agtuTyoc7tnYhsxSo3TcL9Z6+eBY+w5uErQ/taspCEJNy0nhd1tJxlyav
    SaKBATlZW++5dNx0HIop0JCyIXj3lj+Kex/X76L/GlGrDrBKI7WtykoOQtHBiv7pqtTd
    ky35KpdBBGBuNeXD2ouV93ZRHNr2MAbvcnhZ//53jurvtFBoWr7eGpvQ46WD0vjz/b8r
    4tiQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1778608725;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=NSy4R6P/pT+6aAniX5R1PvRqKxggzdyZqdZ+72neo/g=;
    b=jf1S4Yn0ysMUDTQrIWZklU0ga53/H9ySUXi5BnQwjHqh7iL1z4DtDx/zdxwCfWEVqt
    3UxAY6OFeYutdoS3EWrxcHXhvFQjw6AjDbsqrJLQUb+SM5zOHegtAfM8skzoCsoshOkV
    P9sm3MkhHgLIjE3Cb6MuV8W6qvY67CdOkl/83mG3HsK5VVKq42/2LbmdO8tU3GNJ2258
    HmNsd8es9jf4I3VRLQ95lNA9v30V+Sc76cCmsMWqUZIk08Fvk+I3z+78vF255NPDfHc5
    aQz/x1NdV5uy5w4G1xi48btFAZ6VD4iFyS08TcRXJUW6EgM6qvsuMxRUDeW3hFWKTGu+
    GAqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1778608725;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=NSy4R6P/pT+6aAniX5R1PvRqKxggzdyZqdZ+72neo/g=;
    b=iDS6AZ1qFaHr5WLR26/mK7GVeTvvHufEENuKsUbgARi+t2/mNAH+Ao/raIe/B7v6xJ
    +cQuqWZHwxSd5SF9J7BA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s1YTqptmo87qzm6sElmZEI+VN6rw=="
Received: from [IPV6:2a00:6020:4a38:6800:3499:34c0:1f42:76da]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24CHwixBL
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 12 May 2026 19:58:44 +0200 (CEST)
Message-ID: <c2148508-05fb-40a5-bc3c-e1177eccbb9d@hartkopp.net>
Date: Tue, 12 May 2026 19:58:39 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: proc: reset pkg_stats atomics individually
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org
References: <20260512133937.21957-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260512133937.21957-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 486CC526E71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7609-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hartkopp.net:email,hartkopp.net:mid,hartkopp.net:dkim,seu.edu.cn:email]
X-Rspamd-Action: no action



On 12.05.26 15:39, Runyu Xiao wrote:
> Commit 80b5f90158d1 ("can: statistics: use atomic access in hot path")
> converted several members of struct can_pkg_stats to atomic_long_t and
> updated the hot TX/RX and procfs read paths to use atomic_long_*()
> helpers. However, can_init_stats() still clears the whole struct with
> memset().
> 
> can_init_stats() is reached from can_stat_update() in timer context and
> also from the procfs reset path. Those paths can run while the TX/RX hot
> paths are concurrently updating rx_frames, tx_frames, matches and their
> *_delta counters. Hitting the whole-struct memset() in that window
> performs plain writes to fields that otherwise follow an atomic_long_t
> access contract, which can lose or mix live statistics updates.
> 
> This issue was found by source-level API-misuse analysis looking for
> whole-object resets left behind after atomic_long_t conversions, then
> manually audited on Linux v6.18.21.
> 
> Replace the whole-struct memset() with a helper that resets the
> atomic_long_t counters via atomic_long_set() and clears the derived
> scalar statistics explicitly. This preserves the existing reset
> semantics for scalar fields while restoring atomic access discipline for
> the live counters.
> 
> Build-tested by compiling net/can/proc.o on x86_64 netdev/main.
> Runtime-tested with a QEMU + vcan setup on Linux v6.18.21 by driving
> concurrent traffic and reset_stats reads, which reproduced inconsistent
> exported statistics before the fix.
> 
> Fixes: 80b5f90158d1 ("can: statistics: use atomic access in hot path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Makes perfect sense!
Many thanks!

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

> ---
>   net/can/proc.c | 27 +++++++++++++++++++++++++--
>   1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/net/can/proc.c b/net/can/proc.c
> index de4d05ae3459..64b3bdc2fa7e 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -76,16 +76,39 @@ static const char rx_list_name[][8] = {
>    * af_can statistics stuff
>    */
>   
> +static void can_reset_pkg_stats(struct can_pkg_stats *pkg_stats)
> +{
> +	atomic_long_set(&pkg_stats->rx_frames, 0);
> +	atomic_long_set(&pkg_stats->tx_frames, 0);
> +	atomic_long_set(&pkg_stats->matches, 0);
> +
> +	pkg_stats->total_rx_rate = 0;
> +	pkg_stats->total_tx_rate = 0;
> +	pkg_stats->total_rx_match_ratio = 0;
> +
> +	pkg_stats->current_rx_rate = 0;
> +	pkg_stats->current_tx_rate = 0;
> +	pkg_stats->current_rx_match_ratio = 0;
> +
> +	pkg_stats->max_rx_rate = 0;
> +	pkg_stats->max_tx_rate = 0;
> +	pkg_stats->max_rx_match_ratio = 0;
> +
> +	atomic_long_set(&pkg_stats->rx_frames_delta, 0);
> +	atomic_long_set(&pkg_stats->tx_frames_delta, 0);
> +	atomic_long_set(&pkg_stats->matches_delta, 0);
> +}
> +
>   static void can_init_stats(struct net *net)
>   {
>   	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
>   	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
>   	/*
> -	 * This memset function is called from a timer context (when
> +	 * This stats reset is called from a timer context (when
>   	 * can_stattimer is active which is the default) OR in a process
>   	 * context (reading the proc_fs when can_stattimer is disabled).
>   	 */
> -	memset(pkg_stats, 0, sizeof(struct can_pkg_stats));
> +	can_reset_pkg_stats(pkg_stats);
>   	pkg_stats->jiffies_init = jiffies;
>   
>   	rcv_lists_stats->stats_reset++;


