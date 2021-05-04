Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05972372BF9
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 16:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhEDO1y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Tue, 4 May 2021 10:27:54 -0400
Received: from mail-yb1-f180.google.com ([209.85.219.180]:34467 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhEDO1y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 10:27:54 -0400
Received: by mail-yb1-f180.google.com with SMTP id v188so2292030ybe.1
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 07:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IpRRiO4mlKOBNvzXatg5SGAvdvrXnQ0q9E05iS4O6IA=;
        b=jkgHjfnDYHEXz9oMXE9Sjcr9+3hrh6Lbpv5ffvu8tbQl6edq531FAdIx5mPqbU8u82
         Trr43pVIZcdNDBH8pQiEECZyRL3cLyzrr6TdiBBcxjJFdv6SoPd7m2E+EsQdTUkSHobK
         IcETKuWC+EchWcy0jkAWbMPAzn78kZoybPPRqMfDkWieTnA7ocGSx3TOC+Q05BnYkrkc
         DeiaONtnhCD1p0mvSyKnwwfrqPVwkxNXPNPSjs10gjnrhB+Jv8Y08js8vbc03yn3iHp8
         H/2idCQ1J8WVNohcUiL8XRoN7N4RzfprsZZeWulJQ2bDUFz2HiKIt3Pm0wj7vm3Dvoba
         DI7Q==
X-Gm-Message-State: AOAM531J71b0w64KVjkI1My8nKZepu1ju6CyJHjuARChIqeS31UQhnQx
        dLdOG7RBkSBFbEhVLmYzflWTIqYbSCIuek3oHzc=
X-Google-Smtp-Source: ABdhPJz0jjdIpQvRBKmfVz1fnkU5svZpvXozUbUCnabqOidus5UeiTT2L0sqoi2G3QRmHu4EuxGAwFGUCBPhIZxSMwo=
X-Received: by 2002:a25:be09:: with SMTP id h9mr35665286ybk.239.1620138419115;
 Tue, 04 May 2021 07:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
 <20210503100810.cacbmdfmpjipgoka@pengutronix.de> <CAMZ6RqLKp981zBus9K1RiLL14zC0B2BGp0U+xuQGvj1fjDMF1g@mail.gmail.com>
 <DBBPR03MB70828377F51A1747B4E9E6529D5B9@DBBPR03MB7082.eurprd03.prod.outlook.com>
 <20210503154749.q3nrfjveixsqp3uj@pengutronix.de> <DBBPR03MB7082F029173018680E5D869C9D5B9@DBBPR03MB7082.eurprd03.prod.outlook.com>
 <CAMZ6RqJ0t91e-e9LwzaLWTY6G9MY7mosos9-DEs=pc0mWRf86Q@mail.gmail.com>
 <20210504074834.tki7gzr6wz2le6o3@pengutronix.de> <CAMZ6RqK1ZnygjiZ=sXf7zBSodhL1oS1GZz1rcu=92aQ_A-sFew@mail.gmail.com>
 <DM6PR11MB42835BBA69260C24BEAECA2EFB5A9@DM6PR11MB4283.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB42835BBA69260C24BEAECA2EFB5A9@DM6PR11MB4283.namprd11.prod.outlook.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 4 May 2021 23:26:47 +0900
Message-ID: <CAMZ6RqJt0Ai6Uk2ZsOTqD_C1Cw2FTNOg088RXp7UsgHKcAkE2w@mail.gmail.com>
Subject: Re: mcp251xfd receiving non ACKed frames (was: Re: More flags for logging)
To:     Thomas.Kopp@microchip.com
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Ayoub Kaanich <kayoub5@live.com>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 4 Mai 2021 à 21:53, <Thomas.Kopp@microchip.com> wrote:
> Hi All,
>
> > I guess that above error flags are the consequence of the
> > interferences on the bus while unplugging the candlelight. Those
> > are probably not relevant to our specific topic.
> >
> > > | (2021-05-04 09:05:02.100540)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 00
> > 00 00 00
> > > | (2021-05-04 09:05:02.100570)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 00
> > 00 00 00
> > > | (2021-05-04 09:05:02.100583)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 00
> > 00 00 00
> > > | (2021-05-04 09:05:02.100593)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 00
> > 00 00 00
> > > | (2021-05-04 09:05:02.101326)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 00
> > 00 00 00
> > >
> Could be, would be worth to check that one a scope. From what I've seen so far the Bus looks clean without disconnecting nodes.
>
>
> > Second, the receiver behaviour when receiving an non-ACKed frame
> > is actually unspecified. As mentioned before, non-ACKed frames
> > should be immediately followed by an ACK error flag. Here, the
> > receiving nodes are facing a situation which should never
> > occur. The mcp2518fd decides to register the frame as received
> > and the flexcan decides to not register the frame. I think that
> > both behaviors are actually fine: with the lack of specification,
> > the implementation is free to decide how to handle this side
> > case.
>
> I'd say it is actually defined. ISO 11989-1:2015 states the following in chapter 10.4 Bus monitoring
> "Optionally, CAN implementations may provide the bus monitoring mode, where they shall be able to
> receive valid DFs and valid RFs, but it sends only recessive bits on the CAN network and does not start
> a transmission. If the MAC sub-layer is required to send a dominant bit (ACK bit, overload flag, active
> error flag), the bit shall be rerouted internally so that the MAC sub-layer monitors this dominant bit,
> although the CAN network may remain in recessive state."
>
> Looking at the MCAN manual here: https://github.com/linux-can/can-doc/blob/master/m_can/mcan_users_manual_v330.pdf
>
> There's a similar description including a picture showing the TX signal being "connected" internally to the RX path to generate the Ack internally.

Thanks for pointing this out. You are right and I completely
missed that paragraph of the ISO.

So this perfectly explains the behaviour of the mcp251xfd0. It
also means that the ACK flag is set by the transmitter so there
is indeed no way to differentiate if the frame was indeed ACKed
or not by the other nodes.

Concerning the flexcan it is not following the standard. Even if
the monitor mode is optional, once it is implemented, it should
behave as stated in chapter 10.4.

However, this still does not explain why the Peak does not
generate the ACK error flag. Also, the ISO says that in
monitoring mode, the controller "does not start a
transmission". So it also seems like a violation of the standard
that Peak devices are able to transmit frames while being in
monitor mode.


Yours sincerely,
Vincent
