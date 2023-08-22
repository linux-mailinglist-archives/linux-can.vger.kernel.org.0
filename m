Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D440784B25
	for <lists+linux-can@lfdr.de>; Tue, 22 Aug 2023 22:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjHVUJ0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Aug 2023 16:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjHVUJ0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Aug 2023 16:09:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B9FE73
        for <linux-can@vger.kernel.org>; Tue, 22 Aug 2023 13:09:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D72EF63390
        for <linux-can@vger.kernel.org>; Tue, 22 Aug 2023 20:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A9FC433C8;
        Tue, 22 Aug 2023 20:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692734889;
        bh=ra6N/wb5x1BBHlzbEmx5Ek4jkBItk69/AFheKpgiDQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aLUVALpJWxtaTZ3RpHDNXkgDvS9Ns5RjO1hn4jO3tGqyT1sfar39nOJhuFUMEKt31
         JTkfAPvGRHAjlZ01FAK2cGedrwoOzEu77Q5T0tDDdg1tzQMcV6pelzYuhxsgUNoEpy
         Lb9bwqRj2ehpNWavGVVwn8ebln2sTLp96cy6zDXOP89cXvp63lBLiBNInHydZLTLcV
         YuUhJFI7pJ8sbExASW8biKttNNATk52cIDQhUufkKWwIPQPVqSadynMwsjyo05vq5Q
         zX03xWtVS9ks5/vAXtLizJP+dWGFkra2A7KVI8rigllBVir47m7kx6Quo/Ny90lT6Q
         285GPYqg5mldw==
Date:   Tue, 22 Aug 2023 22:08:04 +0200
From:   Simon Horman <horms@kernel.org>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
        edumazet@google.com, mkl@pengutronix.de,
        Ziyang Xuan <william.xuanziyang@huawei.com>
Subject: Re: [NET 2/2] can: raw: add missing refcount for memory leak fix
Message-ID: <20230822200804.GC3523530@kernel.org>
References: <20230821144547.6658-1-socketcan@hartkopp.net>
 <20230821144547.6658-3-socketcan@hartkopp.net>
 <20230822075938.GV2711035@kernel.org>
 <03a97ce3-ee82-5cc0-52cd-2501eeebb240@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03a97ce3-ee82-5cc0-52cd-2501eeebb240@hartkopp.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Aug 22, 2023 at 06:45:25PM +0200, Oliver Hartkopp wrote:
> 
> 
> On 22.08.23 09:59, Simon Horman wrote:
> > On Mon, Aug 21, 2023 at 04:45:47PM +0200, Oliver Hartkopp wrote:
> > > Commit ee8b94c8510c ("can: raw: fix receiver memory leak") introduced
> > > a new reference to the CAN netdevice that has assigned CAN filters.
> > > But this new ro->dev reference did not maintain its own refcount which
> > > lead to another KASAN use-after-free splat found by Eric Dumazet.
> > > 
> > > This patch ensures a proper refcount for the CAN nedevice.
> > > 
> > > Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
> > > Reported-by: Eric Dumazet <edumazet@google.com>
> > > Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
> > > Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > 
> > ...
> > 
> > > @@ -443,44 +448,56 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
> > >   		if (!dev) {
> > >   			err = -ENODEV;
> > >   			goto out;
> > >   		}
> > >   		if (dev->type != ARPHRD_CAN) {
> > > -			dev_put(dev);
> > >   			err = -ENODEV;
> > > -			goto out;
> > > +			goto out_put_dev;
> > >   		}
> > > +
> > >   		if (!(dev->flags & IFF_UP))
> > >   			notify_enetdown = 1;
> > >   		ifindex = dev->ifindex;
> > >   		/* filters set by default/setsockopt */
> > >   		err = raw_enable_allfilters(sock_net(sk), dev, sk);
> > > -		dev_put(dev);
> > > +		if (err)
> > > +			goto out_put_dev;
> > > +
> > >   	} else {
> > >   		ifindex = 0;
> > >   		/* filters set by default/setsockopt */
> > >   		err = raw_enable_allfilters(sock_net(sk), NULL, sk);
> > >   	}
> > >   	if (!err) {
> > >   		if (ro->bound) {
> > >   			/* unregister old filters */
> > > -			if (ro->dev)
> > > +			if (ro->dev) {
> > >   				raw_disable_allfilters(dev_net(ro->dev),
> > >   						       ro->dev, sk);
> > > -			else
> > > +				/* drop reference to old ro->dev */
> > > +				netdev_put(ro->dev, &ro->dev_tracker);
> > > +			} else {
> > >   				raw_disable_allfilters(sock_net(sk), NULL, sk);
> > > +			}
> > >   		}
> > >   		ro->ifindex = ifindex;
> > >   		ro->bound = 1;
> > > +		/* bind() ok -> hold a reference for new ro->dev */
> > >   		ro->dev = dev;
> > > +		if (ro->dev)
> > > +			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
> > >   	}
> > > - out:
> > > +out_put_dev:
> > > +	/* remove potential reference from dev_get_by_index() */
> > > +	if (dev)
> > > +		dev_put(dev);
> > 
> > Hi Oliver,
> > 
> > this is possibly not worth a respin, but there is no need to check if dev
> > is NULL before calling dev_put(), dev_put() will effectively be a no-op
> > with a NULL argument.
> > 
> 
> Hi Simon,
> 
> thanks for your feedback.
> 
> In fact I had in mind that someone recently removed some of these "if (dev)"
> statements before "dev_put(dev)" in the netdev subtree.
> 
> The reason why I still wanted to point out this check is because of dev ==
> NULL is also a valid value for CAN_RAW sockets that are not bound to a
> specific netdev but to 'ALL' CAN netdevs.
> 
> So it was more like a documentation purpose than a programming need.
> 
> As you don't see a need for a respin too, I can send a patch to can-next to
> remove it, if that fits for you.

Thanks Oliver, that would be fine by me.
