Return-Path: <linux-can+bounces-6177-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14540D31A2F
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 14:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 998893089A20
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153B6225A38;
	Fri, 16 Jan 2026 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="kYyBtqSc";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sB9OXWlR"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE7C23C512;
	Fri, 16 Jan 2026 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569244; cv=pass; b=u/kU0aGiDmYp/6jLfpziFkR87/w3yfOjSzPfROV1Cg+1f5yymWPA7Zll+j43ydIP+4aufKfvwxa5OluDyNtKFn02A58GOfb9TnsoQ05/MwMYPB9B6PQGrkqpz5XcHPDXqgFmLDwthxuP81spu1jPWGcC2YuIiXDuXF9WSUoSsu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569244; c=relaxed/simple;
	bh=Wuve9MvzWJHx0XFHh23N51szb/KdRwFynWt/oKCbNNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEI7zZV2MJBGwMIDydZWo0SdI00M3MgtENKf8KNzOk4ak8rAknZpBsmkl1vmIX9BjwxwmrtOQc6zEf64qqr0VLv64UMaMsxp4B7YbUfO+e4Pqt3cQ5fhxstGz+Q4N91K6/it60wwNpuvb/ahRoRNmeUTFhfJk1vNtdBMB4KkOG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kYyBtqSc; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sB9OXWlR; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768569050; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hkJapfWFzRJedGwzOUEqS2cJEvE+PpQCNwI5Gv98ZLgX7EjBOfZO7x7ldmpHssYbZd
    Wsb/LsiPuZTXutlCvCQcM7fyvTikpm0r/QX4yPNxEI2p1Bux1wm2Vvyr7i52KM7rzVZp
    o9kHxrEvBs8cPN2Q8pSqT8wDpS1MeK5pAJAIdRKOeNQbNyJ4D5CsFsqJAWw2CHoe+KOY
    u/h61eTS7lZaO4CMWX5xvc0tLbWIN+pV+Ir6yiJxa7AWkRlrByr7eU6aoqWVXasnc1tg
    lQBpA1Qf2DIb+fOqY4y/bfQqZp9wf7K5Wy1/G6gGQ3KlXmJTYEQ/FFwn1rfetJ3QHX1w
    q6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768569050;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+qhtqEO9l0a4x0eJcT2mQ6rZpjlZ1f95I59ejo8saRc=;
    b=A6RwpaM7ccXeK4r3NFTanP6rEDzp2luAhahZrQLx6IFos45kusr2kgduwevrLuwbpW
    FynfMe7i8EQ8rDFK2Cu6KE44Gyi72fAYtmz3WBdPZ54013VGdKasF2Skjx5dIzbmrNwy
    +13v82SFFqXV906OgF3mQxFfFGirPhlCd4dn+CITWI+Ln6xsDm5bCkqEVREQ3Q77aQyZ
    +Kq20WyY2/rlnfQYGBcuVRvJdWbzZ62PAENOuZ3wzu7q/DXvinE8c1W3HGpHvdtRGGi4
    WuWSPkIUhOInTUBkQnjojuSZ5OxgOce2AnD3JO/JhJi53e78vs2PXPRbF2tk5crN2wqE
    xi7Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768569050;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+qhtqEO9l0a4x0eJcT2mQ6rZpjlZ1f95I59ejo8saRc=;
    b=kYyBtqScDpoiBmctnK7agLEE9QU14hM31k0vuthA/AqYPANNwbFFSHz2kak7Dn6WcX
    QnQpxj1cKzkz6axcKS2gjk9Ofmm9JK+On3uQKYGj3eq9LEUBICfszH3GEcU6TQD77Dt5
    WW3DImun8vorpTe0sDAB+PZ19pf9tMckfh3kHXZCMtLQ0oAWJWiP5xLcqeNqRfXe5G8F
    G21H8hiDlhNWZXNF+D6t47y54f218g3K+Bzfv6DWRoTuST3BkyuuNeAkMtQ+R30zXmLP
    7NhOWDYbMNMzI7H6TmOcMM9DeJQcLjytvlbLisKiTEYw2vOGbrzMoBA0aJcwhJOJZfvY
    nCcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768569050;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+qhtqEO9l0a4x0eJcT2mQ6rZpjlZ1f95I59ejo8saRc=;
    b=sB9OXWlRyawgIyfemNhi8KpfzfEGSSijVM6ir4uQY32QBWB8CPkXzk1sx14DI6nJEj
    wfc+2oyUwd669yV6StBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20GDAoCpE
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Jan 2026 14:10:50 +0100 (CET)
Message-ID: <fc7ea750-78bf-42a6-ba3e-4db53a24ca25@hartkopp.net>
Date: Fri, 16 Jan 2026 14:10:44 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: dev: alloc_candev_mqs(): add missing default CAN
 capabilitied
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
References: <20260116-can_add_missing_set_caps-v1-1-7525126d8b20@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260116-can_add_missing_set_caps-v1-1-7525126d8b20@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16.01.26 13:44, Marc Kleine-Budde wrote:
> The idea behind series 6c1f5146b214 ("Merge patch series "can: raw: better
> approach to instantly reject unsupported CAN frames"") is to set the
> capabilities of a CAN device (CAN-CC, CAN-FD, CAN-XL, and listen only) [1]
> and, based on these capabilities, reject unsupported CAN frames in the
> CAN-RAW protocol [2].
> 
> This works perfectly for CAN devices configured in CAN-FD or CAN-XL mode.
> CAN devices with static CAN control modes define their capabilities via
> can_set_static_ctrlmode() -> can_set_cap_info(). CAN devices configured by
> the user space for CAN-FD or CAN-XL set their capabilities via
> can_changelink() -> can_ctrlmode_changelink() -> can_set_cap_info().
> 
> However, in commit 166e87329ce6 ("can: propagate CAN device capabilities
> via ml_priv"), the capabilities of CAN devices are not initialized.
> This results in CAN-RAW rejecting all CAN frames on devices directly
> after ifup if the user space has not changed the CAN control mode.

Ah! It's about setting the bitrate without changing the control mode.

Sorry. I tested multiple configurations several times but missed the 
most simple one as initial test :-/

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Best regards,
Oliver

> 
> Fix this problem by setting the default capabilities to CAN-CC in
> alloc_candev_mqs() as soon as the CAN specific ml_priv is allocated.
> 
> [1] commit 166e87329ce6 ("can: propagate CAN device capabilities via ml_priv")
> [2] commit faba5860fcf9 ("can: raw: instantly reject disabled CAN frames")
> 
> Fixes: 166e87329ce6 ("can: propagate CAN device capabilities via ml_priv")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   drivers/net/can/dev/dev.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 7ab9578f5b89..769745e22a3c 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -332,6 +332,7 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
>   
>   	can_ml = (void *)priv + ALIGN(sizeof_priv, NETDEV_ALIGN);
>   	can_set_ml_priv(dev, can_ml);
> +	can_set_cap(dev, CAN_CAP_CC);
>   
>   	if (echo_skb_max) {
>   		priv->echo_skb_max = echo_skb_max;
> 
> ---
> base-commit: a74c7a58ca2ca1cbb93f4c01421cf24b8642b962
> change-id: 20260116-can_add_missing_set_caps-388627edda13
> 
> Best regards,
> --
> Marc Kleine-Budde <mkl@pengutronix.de>
> 


