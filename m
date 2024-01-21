Return-Path: <linux-can+bounces-138-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66475835519
	for <lists+linux-can@lfdr.de>; Sun, 21 Jan 2024 11:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992A7282196
	for <lists+linux-can@lfdr.de>; Sun, 21 Jan 2024 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14715364B6;
	Sun, 21 Jan 2024 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="F0DWSueS";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="FZ/HRAS2"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8A1364B5
	for <linux-can@vger.kernel.org>; Sun, 21 Jan 2024 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705831672; cv=pass; b=icH1zboE6vQRwN3TmJ/UpIQbOpa8ncp1FMcmMxFWtACCP3l91G2XMAC1CYDYcf2Qf85h/6Z3n0xb6sLrF1xHlo5d5yftl2gs5UxNt8J7gK1bbg/eZVDh5cyYfSkIOCxjpuJOiwhVCHFqAwaManfs4mq/h2PgKJ0mczl9hDxA7Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705831672; c=relaxed/simple;
	bh=VVYr/gxuOd17xGubY38ftP+LRH1QHcaCEsN9fbONjhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGGOYJPW6eO6RyLJa3DH3McqE2mwlDaxtKzwBnIa31c8NWq4n7EF9gIL824W222f7SBPTuhtkY0icLdjSqQf/Gq3DLHKfYqOV8V0vvOYhDL+rqz5Jg1dn43iFQFXS8HVEWuCFpVLvzQYZz8DQmzHsQxQYJizKIF6CXluotqsucc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=F0DWSueS; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=FZ/HRAS2; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1705831660; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SZMp99iVmrO9NcVpe+bI0DfbD00CIAldoKssKhnwBVcgy//HRtz74FSA5jtEQ+DerM
    OFoWFNBDKRl8YFaeZkkRo3MIgn1PxmeqODGgBFn75CLJN3V81sLaxUaNIA8bYu5MPjfR
    N3d0NykisnHSWSYioFFcOiMT/iIZq/PqzNxqrQUqsgEk0t7wTVnZ4eTlIJO77ds6rrBQ
    Zml1rQtFruNSbYG2GQrndQPWsOvZ1uyJDfK1VIIXyNVcYaXDBSn/8o9fLqaEvYIl+drO
    ohz0RW1M65mnZLi0NhkGZJ7+BbRf4LsjG8BNp7hh644LAEGNVu6rbrAXqq5H2Jj3EWN6
    IERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1705831660;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=TNLmG9B9i6oB3NwM/MWkshdiPTk7WQoyEBtR0Pyr/Ak=;
    b=Kij5ScD3LoouDGe8VARbdmh2lvKdSk9EWQ6nkD/vedwXGtpoQXu9LCfKZkKGwmfDeW
    9zR/1JAbwHdIZtQTp/NtwdfTYu4ngi3cyJbyaqF+L243TxxFElDxliA7j7hE/zM7sGLk
    f5DBKxOdrf5V60KzFi5WeO8ZGYPMZnohJo3NCl5PkDLXKlURHKpHJjNh3cjsEemMJ1dp
    Po61uVbY3wos7A1ukCLzE4S1ZnE11rHqbDbywOTl7RgFo2ogspW9tsGu7rE4jvG9aOXm
    f58eKIccy1LqPm2Ch3T37lddcnbL/Mc3Dv1zXpyS2rX+sIMHZZTWqdbaGMJI2tJ2TAit
    ip2w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1705831660;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=TNLmG9B9i6oB3NwM/MWkshdiPTk7WQoyEBtR0Pyr/Ak=;
    b=F0DWSueS2x7mX7kv8jg6rKYQHsyKqskydnRGlFyr7wsF/WoiRmr+2oeRFFUja+lXOu
    zpyOQ320tqfkvQbWxc/mAgUibvxUcnN0hFtsJ1Hp/cHLhMxGGlp8rFHpT4TqcWFetNm9
    mTI8wL2YEWUtlGX5K02p/2JSWp3qdSwpDDNfFefb/W8wHywC9JWoBfWYEK5rPEcMxzyf
    MOmEqe8aRgp0ubq/HP7PJxG/qTAZWSoDMVYKXZrKQsiiXxJwRLeRcwjZYyxYnKKsXmG2
    EICiXgOzzZZvxa2CNfvJp6wYxrKZZ+RpVofkCS4kd3e5twEM88nVaAjeA5ahKhCrWO2O
    baBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1705831660;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=TNLmG9B9i6oB3NwM/MWkshdiPTk7WQoyEBtR0Pyr/Ak=;
    b=FZ/HRAS2jaLBPOLOCmYsy0N9JkyDMxWQ1vHJwmi7VFhL4ANDGQ4U87EIFkx2StE0s+
    urGhP5Rifc2ewaEPrcDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDdAnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::90c]
    by smtp.strato.de (RZmta 49.10.2 AUTH)
    with ESMTPSA id K7b2c200LA7ecF2
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 21 Jan 2024 11:07:40 +0100 (CET)
Message-ID: <b42b9988-98b5-411a-8493-b9d3d534c7d7@hartkopp.net>
Date: Sun, 21 Jan 2024 11:07:34 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] can: gw: fix RCU/BH usage in cgw_create_job()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-can@vger.kernel.org, tglx@linutronix.de
References: <20231221123703.8170-1-socketcan@hartkopp.net>
 <20240111121402.xc9rmYfG@linutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20240111121402.xc9rmYfG@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-11 13:14, Sebastian Andrzej Siewior wrote:

> Why are you afraid of doing
> 	mod = kmalloc(sizeof(*mod), GFP_KERNEL);
> 
> before invoking cgw_parse_attr()?

The update of the modification content should be performed instantly and 
without any potential scheduling from kmalloc().

As you pointed out one of the problems may arise from changing the 
modification functions but not from changing the modification content.

So what about the below patch then?

Would a spin_lock() or spin_lock_bh() be an alternative to lock this 
update against the modification execution in can_can_gw_rcv()?

Best regards,
Oliver

diff --git a/net/can/gw.c b/net/can/gw.c
index 37528826935e..79aeb380b66a 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -1085,21 +1085,27 @@ static int cgw_create_job(struct sk_buff *skb, 
struct nlmsghdr *nlh,
  	if (mod.uid) {
  		ASSERT_RTNL();

  		/* check for updating an existing job with identical uid */
  		hlist_for_each_entry(gwj, &net->can.cgw_list, list) {
+			int mi;
+
  			if (gwj->mod.uid != mod.uid)
  				continue;

  			/* interfaces & filters must be identical */
  			if (memcmp(&gwj->ccgw, &ccgw, sizeof(ccgw)))
  				return -EINVAL;

-			/* update modifications with disabled softirq & quit */
-			local_bh_disable();
+			/* modification functions must be identical */
+			for (mi = 0; mi < MAX_MODFUNCTIONS; mi++) {
+				if (gwj->mod.modfunc[mi] != mod.modfunc[mi])
+					return -EINVAL;
+			}
+
+			/* update only the modification content & quit */
  			memcpy(&gwj->mod, &mod, sizeof(mod));
-			local_bh_enable();
  			return 0;
  		}
  	}

  	/* ifindex == 0 is not allowed for job creation */


