Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D882EC4A02
	for <lists+linux-can@lfdr.de>; Wed,  2 Oct 2019 10:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfJBIxk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Oct 2019 04:53:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34680 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJBIxk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Oct 2019 04:53:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id r22so12138410lfm.1
        for <linux-can@vger.kernel.org>; Wed, 02 Oct 2019 01:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=10quKWdkdSX2fA23T9/E+QzGrFO+1RMr79+kLKSwUz0=;
        b=YU21xloDT6riTCfhZ/e9RE2ejmvMnMAMhz8ILBZAZBjs8v9nLx+XxaPTUbd+lJEW6h
         pje7JmrCKkDKYnMNvQyIZh8+kG39VwXTMtIGsKTKwJ6JAcqqobDjxHj6VTQ9GhPLJHqm
         u97e62PDCi9oR7uSazVjwe4xfvloqTF7SHf2CVvwd4mvfXfBsiYergq384iCPsvaafUj
         Lk2KB53Z5sCJnawoNCzj8TABOylQf7R350zeSyr9WzucZNQNvhWA8gFx8D7R9Okc3PQi
         Su349onZjYDg7M231ZEQ6z/HL1QRd3m3aRTctMrdl33b/pVqyd3d3rwtLLbYHSH41GYs
         2fgw==
X-Gm-Message-State: APjAAAVurnVsJ+vmV4MpbITBxbf8jTAqVi7edLM5aDSpe71FJeUL8m6l
        bRe2BkJSaLAR6qXR8wz/CUw=
X-Google-Smtp-Source: APXvYqzJtcLg+l9dTBqS1pjcYXMamARRmw0+TCyT4FvBPjhrGMzdz9+H127OqQpp3g7mKF96HIs83g==
X-Received: by 2002:ac2:4c8f:: with SMTP id d15mr1663010lfl.74.1570006418049;
        Wed, 02 Oct 2019 01:53:38 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id g10sm4466249lfb.76.2019.10.02.01.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 01:53:37 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iFaOI-00024W-PE; Wed, 02 Oct 2019 10:53:46 +0200
Date:   Wed, 2 Oct 2019 10:53:46 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bernd =?iso-8859-1?Q?Krumb=F6ck?= <b.krumboeck@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-can@vger.kernel.org
Subject: Re: [PATCH 2/2] can: usb_8dev: fix use-after-free on disconnect
Message-ID: <20191002085346.GP13531@localhost>
References: <20191001102914.4567-1-johan@kernel.org>
 <20191001102914.4567-3-johan@kernel.org>
 <CAJAQPp3Djr4thY_62BHOUThz=X_8eA-R-De1PEdvDpmSYZH6EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJAQPp3Djr4thY_62BHOUThz=X_8eA-R-De1PEdvDpmSYZH6EQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Oct 02, 2019 at 10:10:17AM +0200, Bernd Krumböck wrote:
> My knowledge about the kernel structures are very limited, so please
> appologize the question.
> Can you explain/show me where the use occurs?

The driver privata data is allocated in probe() by alloc_candev():

	netdev = alloc_candev(sizeof(struct usb_8dev_priv), MAX_TX_URBS);
	...
	priv = netdev_priv(netdev);

and is freed in disconnect() along with the candev:

	free_candev(priv->netdev);

but the driver was accessing priv after having freed it (the
unlink_all_urbs() call).

Johan

> Am Di., 1. Okt. 2019 um 12:29 Uhr schrieb Johan Hovold <johan@kernel.org>:
> 
> > The driver was accessing its driver data after having freed it.
> >
> > Fixes: 0024d8ad1639 ("can: usb_8dev: Add support for USB2CAN interface
> > from 8 devices")
> > Cc: stable <stable@vger.kernel.org>     # 3.9
> > Cc: Bernd Krumboeck <b.krumboeck@gmail.com>
> > Cc: Wolfgang Grandegger <wg@grandegger.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/net/can/usb/usb_8dev.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/can/usb/usb_8dev.c
> > b/drivers/net/can/usb/usb_8dev.c
> > index d596a2ad7f78..8fa224b28218 100644
> > --- a/drivers/net/can/usb/usb_8dev.c
> > +++ b/drivers/net/can/usb/usb_8dev.c
> > @@ -996,9 +996,8 @@ static void usb_8dev_disconnect(struct usb_interface
> > *intf)
> >                 netdev_info(priv->netdev, "device disconnected\n");
> >
> >                 unregister_netdev(priv->netdev);
> > -               free_candev(priv->netdev);
> > -
> >                 unlink_all_urbs(priv);
> > +               free_candev(priv->netdev);
> >         }
> >
> >  }
> > --
> > 2.23.0
> >
> >
