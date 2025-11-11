Return-Path: <linux-can+bounces-5337-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EACB6C4F898
	for <lists+linux-can@lfdr.de>; Tue, 11 Nov 2025 20:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DFBC3B3054
	for <lists+linux-can@lfdr.de>; Tue, 11 Nov 2025 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC28E2E540C;
	Tue, 11 Nov 2025 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="l+SIhU9l";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KR26c79D"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8732E2663
	for <linux-can@vger.kernel.org>; Tue, 11 Nov 2025 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888119; cv=pass; b=lt8K6pxLreTJcdzzBBLluOYgOVT6navmNQ8eaCNtG8WfIVb9UzPSmy/XLAtDfzd/ELA4FbjndvI2R0/nyaOC9J+Ts81pW7oxtOBG86omF4XKE98VM7TPdcopZHd/JzRd4sEc8tC3IWSWiy2OfHVSinR8+iFvLJzeRDF3V9oaB7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888119; c=relaxed/simple;
	bh=/FZ6pwxo7J5zBhbmydQd/aZOFEoYwaWHuoaWy+jXGqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S/9LbBeX3SZ009n7+jnIncrcMo7AwVPQzKwPwHrJEsJDjLEh9f8un+fskDiyNosrgiegiEritPnfeCi1odd2VxKjEmfwp0I4xgY+DHORkxQ2PbNWDpRR1SpctCM1EH4wOc6KBdk6w5yYavP5U4wfrUMpvujQL2Z/+L8sumDIA/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=l+SIhU9l; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KR26c79D; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1762887741; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=N3cGRCVK1yA33Nr5tnMWFZ2VrwqXFB/PvntifgGEWmSEqhlh4LNxbWyCU7ol/ryM5h
    wOsTqXbG4xCqFma8U+hc6fOYs4lfEwteE3Ekyw3Oebyo57EOMvhFp2na1gU6RPmIcuZ+
    YCUWj/JSMCDh7RJ2rhjvQUwJgHOYH2dsyxTk5dl8mNMYUDZyyYzm+flxeDo+2wU2C7dH
    yzyLkN37C5C82qatR9oi5e8OnfULA25/V59jYNZ4eqilRYM8X56JCrHKRtmgH7wLkESp
    FDvnTPOZQAJzvZ07n3BunCep9aGyY7YqZP+XPAzG+GojIdgV2bKH9qTgplLoKKsP4eUx
    U0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762887741;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=MHVDTvA52a3HQkVEh1S7YjsvqdHIAmJ1HvBWXo0jPfE=;
    b=nLuSUO0sIlPuXD5Jd09gD9DIwDl7PflxbFlSxCqnodaf4Gywk2rA+wQDZsWcXG8NHB
    ui3ZZmnLtGQKzJ+VecsJomQc7wQSaSPwP+U5I7kpwkP8LAe+PleRQW5BVhAs7cpdXp2o
    t/wHeh0kOYA3P8rR6XhzWuhMi8rFkXqBH0D+z/WWSA5Wg56ExGCJ7PE13tCn/fgLmttR
    t2SNbFsjyZRQWIti+MvyXy4hs0r9lKY45rM8aIop5GRptdqo/0tTdMy4P2cM2f3IqsUQ
    tCew1qI2VzwfwnD2Y8SPY34en1+QSJOSPyOkP7BbbZgpaK5eSHVPvLi9rtP4bxB3StRO
    7t9Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762887741;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=MHVDTvA52a3HQkVEh1S7YjsvqdHIAmJ1HvBWXo0jPfE=;
    b=l+SIhU9lQ1Kc0UZe54vG9Fi9Xi0dM29IWSrIr7NnEE0zpAdJ79Q4sZij/jtC5xwLz6
    VNaWI/skdhVIEjrFdTtFROfn4wKhRc/lDZH6A4lzvrk5Kprf6kh8D0tb3K8a4iItGgnu
    V/Mqzi8mrhUBhB2GfS6CUJmA4mnWN/ABaQ9GnGnVlgRgMJVhgjwC76CFE2SvBO4vTWM2
    EAMgyWqiIV1UyXmh6BqzakMoSSAsY3ydj08azVcQx4KqAgTjhbq3TS+IZnRVUxtWDkwh
    9N40uvDHDLCwXaFC6OfoPc2f7YYljGrLLlTbrHX6K15NqTgRliZffPrZm3NZLn1o+ML4
    OCWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1762887741;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=MHVDTvA52a3HQkVEh1S7YjsvqdHIAmJ1HvBWXo0jPfE=;
    b=KR26c79DDHdQaQeEOQFqgpZ2Qt2CAP4BM0J/xEiKEWoe+VPkPj5uEwtMj32VM31vKH
    yox3Ze9Nqe/Jh4V2DsCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ABJ2LPjL
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 11 Nov 2025 20:02:21 +0100 (CET)
Message-ID: <3a0d233d-3963-49be-90ef-d1ed3b1401c4@hartkopp.net>
Date: Tue, 11 Nov 2025 20:02:15 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH b4/canxl-netlink v2] can: drop unsupported CAN frames on
 socket and netdev level
To: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
References: <20251103185336.32772-1-socketcan@hartkopp.net>
 <a76a6805-d04a-44c0-9ccb-19fc2636ff7e@kernel.org>
 <d20139f0-be38-428f-9205-dd85e59eb1d9@hartkopp.net>
 <f7665b08-57cd-4b42-8a2f-7a86059eaee2@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <f7665b08-57cd-4b42-8a2f-7a86059eaee2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 10.11.25 22:53, Vincent Mailhol wrote:

> Do we really need a function for that? This is how my draft
> can_dev_dropped_skb() looks like at the moment:
> 
>    /* drop skb if it does not contain a valid CAN frame for sending */
>    static inline bool can_dev_dropped_skb(struct net_device *dev,
>    					 struct sk_buff *skb)
>    {
>    	struct can_priv *priv = netdev_priv(dev);
>    	u32 silent_mode = priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
>    					    CAN_CTRLMODE_RESTRICTED);
> 
>    	if (silent_mode) {
>    		netdev_info_once(dev, "interface in %s mode, dropping skb\n",
>    				 can_get_ctrlmode_str(silent_mode));
>    		goto invalid_skb;
>    	}
> 
>    	if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb)) {
>    		netdev_info_once(dev, "CAN FD is disabled, dropping skb\n");
>    		goto invalid_skb;
>    	}
> 
>    	if (!can_err_signal_is_enabled(priv) && !can_is_canxl_skb(skb)) {
>    		netdev_info_once(dev,
>    				 "Error signaling is disabled, dropping skb\n");
>    		goto invalid_skb;
>    	}
> 
>    	return can_dropped_invalid_skb(dev, skb);
> 
>    invalid_skb:
>    	kfree_skb(skb);
>    	dev->stats.tx_dropped++;
>    	return true;
>    }
> 
> (refactored to use the new can_err_signal_is_enabled() as proposed above).
> 
> Also, if the above looks good to you, you can leave the can_dev_dropped_skb() to
> me and just focus on the can_dropped_invalid_skb() and the raw.c.

Agreed. I sent a patch for raw.c only:

https://lore.kernel.org/linux-can/20251111185152.23193-1-socketcan@hartkopp.net/T/#u

But I wonder how many checks are really needed in can_dev_dropped_skb() 
as it later calls can_dropped_invalid_skb().

We should try not to check the same conditions multiple times.

Best regards,
Oliver

ps. can_dev_err_signal_is_disabled() is already using the FD/XL 
mixed-mode detection as I hope we will drop CAN_CTRLMODE_XL_ERR_SIGNAL ;-)

