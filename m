Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96223E848B
	for <lists+linux-can@lfdr.de>; Tue, 10 Aug 2021 22:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhHJUr6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Aug 2021 16:47:58 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:52402 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230181AbhHJUr5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Aug 2021 16:47:57 -0400
Received: from MTA-06-3.privateemail.com (mta-06-1.privateemail.com [68.65.122.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 93686814DE
        for <linux-can@vger.kernel.org>; Tue, 10 Aug 2021 16:47:34 -0400 (EDT)
Received: from mta-06.privateemail.com (localhost [127.0.0.1])
        by mta-06.privateemail.com (Postfix) with ESMTP id A2D5F18003ED;
        Tue, 10 Aug 2021 16:47:33 -0400 (EDT)
Received: from localhost (unknown [10.20.151.245])
        by mta-06.privateemail.com (Postfix) with ESMTPA id 7B2F518000AE;
        Tue, 10 Aug 2021 16:47:33 -0400 (EDT)
Date:   Tue, 10 Aug 2021 13:47:32 -0700
From:   Matt Kline <matt@bitbashing.io>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v2 2/2] can: m_can: Batch FIFO writes during CAN transmit
Message-ID: <YRLl5PavqmjkIkeD@kline-desktop>
References: <20210727015855.17482-1-matt@bitbashing.io>
 <20210727015855.17482-3-matt@bitbashing.io>
 <20210804091858.vvvrzrmnmi76mg3c@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804091858.vvvrzrmnmi76mg3c@pengutronix.de>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Aug 04, 2021 at 11:18:58AM +0200, Marc Kleine-Budde wrote:
> >  
> > -	cdev->ops->write_fifo(cdev, addr_offset, val);
> > +	result = cdev->ops->write_fifo(cdev, addr_offset, val, val_count);
> > +	WARN_ON(result != 0);
> 
> What about converting all read/write functions to return an error, and
> handle the error in the caller?

Yeah, that would be cleaner.

> >  	/* acknowledge rx fifo 0 */
> > @@ -1546,8 +1548,8 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
> >  	struct net_device *dev = cdev->net;
> >  	struct sk_buff *skb = cdev->tx_skb;
> >  	u32 id, cccr, fdflags;
> > -	int i;
> >  	int putidx;
> > +	u32 id_and_dlc[2];
> 
> Can you create a struct for this?

Ditto, sure!

> >  
> >  	cdev->tx_skb = NULL;
> >  
> > @@ -1563,18 +1565,16 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
> >  	if (cf->can_id & CAN_RTR_FLAG)
> >  		id |= TX_BUF_RTR;
> >  
> > +	id_and_dlc[0] = id;
> > +
> >  	if (cdev->version == 30) {
> >  		netif_stop_queue(dev);
> >  
> > -		/* message ram configuration */
> > -		m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, id);
> > -		m_can_fifo_write(cdev, 0, M_CAN_FIFO_DLC,
> > -				 can_fd_len2dlc(cf->len) << 16);
> > +		id_and_dlc[1] = can_fd_len2dlc(cf->len) << 16;
> >  
> > -		for (i = 0; i < cf->len; i += 4)
> > -			m_can_fifo_write(cdev, 0,
> > -					 M_CAN_FIFO_DATA(i / 4),
> > -					 *(u32 *)(cf->data + i));
> > +		/* Write the frame ID, DLC, and payload to the FIFO element. */
> > +		m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, id_and_dlc, ARRAY_SIZE(id_and_dlc));
> > +		m_can_fifo_write(cdev, 0, M_CAN_FIFO_DATA, cf->data, DIV_ROUND_UP(cf->len, 4));
> 
> Does it make sense to combine these, too? Same for the v3.1 variant.

I think that's the eventual goal, but since the ID, DLC, and frame data would
have to be contiguous for a single m_can_fifo_write(), you'd end up copying
things around. I wanted to start with this smaller, simpler patch first.
Is that alright?

I'll try to send a v3 up shortly.

Best,
Matt
