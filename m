Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 551DD1974CD
	for <lists+linux-can@lfdr.de>; Mon, 30 Mar 2020 09:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgC3HCR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 30 Mar 2020 03:02:17 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:36019 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbgC3HCQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 30 Mar 2020 03:02:16 -0400
X-ASG-Debug-ID: 1585551731-0a88181c9bbe5e10001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be ([77.109.89.38]) by relay-b03.edpnet.be with ESMTP id E5ciL5rTjEMZm2K5; Mon, 30 Mar 2020 09:02:11 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: UNKNOWN[77.109.89.38]
X-Barracuda-Apparent-Source-IP: 77.109.89.38
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id A48FDDCCAE8;
        Mon, 30 Mar 2020 09:02:11 +0200 (CEST)
Date:   Mon, 30 Mar 2020 09:02:03 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Felix Riemann <Felix.Riemann@sma.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Andre Kalb <Andre.Kalb@sma.de>
Subject: Re: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
 disabled
Message-ID: <20200330070203.GE22500@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
 disabled
Mail-Followup-To: Felix Riemann <Felix.Riemann@sma.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Andre Kalb <Andre.Kalb@sma.de>
References: <20200326104318.15086-1-felix.riemann@sma.de>
 <20200326134015.GC27785@x1.vandijck-laurijssen.be>
 <AM0PR04MB5427D3BF64C3D3DA3961920488CF0@AM0PR04MB5427.eurprd04.prod.outlook.com>
 <20200326193837.GF760@x1.vandijck-laurijssen.be>
 <AM0PR04MB542742337A89900E12A8732288CC0@AM0PR04MB5427.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM0PR04MB542742337A89900E12A8732288CC0@AM0PR04MB5427.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: UNKNOWN[77.109.89.38]
X-Barracuda-Start-Time: 1585551731
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 5887
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8072 1.0000 2.2895
X-Barracuda-Spam-Score: 2.79
X-Barracuda-Spam-Status: No, SCORE=2.79 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_RULE7568M, INFO_TLD
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.80891
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 INFO_TLD               URI: Contains an URL in the INFO top-level domain
        0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On vr, 27 mrt 2020 10:09:03 +0000, Felix Riemann wrote:
> Is it this one?
> https://marc.info/?l=linux-can&m=157683579518282

yes

> 
> It seems to be missing patch 6 in the series.

you can get there via https://github.com/kurt-vd/linux, branch c_can-next

Kurt

> 
> Regards,
> Felix
> 
> -----Original Message-----
> From: Kurt Van Dijck
> Sent: Thursday, March 26, 2020 8:39 PM
> 
> Interesting topic.
> 
> After the bus-off problem, I also attacked the overflow problems. No
> idea why this patch series got stalled. I activated the complete 64
> message buffers of the D_CAN hardware (only 64 of the 128 being present
> in the IP for some reason I don't know) and modified the IRQ to use
> rx-offload. That may affect the circumstances under load, I admit.
> 
> Whould you mind trying that series, just for reference, in your setup?
> If your hypothesis is right, my observations do not survive your
> busload.
> 
> Kind regards,
> Kurt
> 
> On do, 26 mrt 2020 14:49:23 +0000, Felix Riemann wrote:
> > Hi Kurt,
> >
> > yes that would be 3cb3eaac52c0f145d895f4b6c22834d5f02b8569.
> >
> > I tried your patch as well, since the description matched the problem pretty well. However, I could still produce the hang on our board (based on AM3352) especially if the bus off occurs while the bus load is very high.
> >
> > What I could see was the worker being triggered by the interrupt with the bus being in passive mode. When the worker then re-enabled the interrupt the hardware had already entered init mode due to the bus-off but nor would it trigger again nor would the interrupt register indicate a pending IRQ. The status register also indicates an error (LEC != 0x7).
> >
> > A first attempt to fix/workaround this placed the check just before the worker re-enables the interrupts. But even this setup could reproduce the problem, although it took longer to do so.  So the timing around enabling the interrupts seems to matter here. Actually, adding a printout at the top of the worker where your patch checks the value of the sie_pending atomic seems to increase the chances of making it happen on my board, but that's just a feeling I got while cleaning up my patch.
> >
> > Regards,
> >
> > Felix
> >
> > -----Original Message-----
> > From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> > Sent: Thursday, March 26, 2020 2:40 PM
> >
> > This patch looks very familiar.
> > I tried this 6 months ago, when I got a setup where I could reproduce this within minutes.
> >
> > This patch didn't solve my problem, and I fixed my problem with reading the ISR register only once in the IRQ, and _not_ 2nd time in napi handler.
> > Reading the ISR in C_CAN is consuming the info, so unless the there is more state to clear (such as received message buffers), the interrupt cause is assumed to be known, and the C_CAN proceeds to the next interrupt cause.
> > I've not experienced a single problem since, where before the fix, I'd experience a few occurances every month.
> > We have an am3358 (beaglebone-like hardware).
> >
> > I believe I submitted a patch for that.
> >
> > Re-scheduling the napi is a workaround, IMHO.
> >
> > Kurt
> >
> > On do, 26 mrt 2020 11:43:18 +0100, Felix Riemann wrote:
> > > There are appears to be a race condition where interrupts caused by
> > > bus offs get lost if it occurs while interrupts are disabled or being
> > > re-enabled.
> > >
> > > This tries to avoid the deadlock by rescheduling the NAPI worker to
> > > handle the bus-off condition.
> > >
> > > Signed-off-by: Felix Riemann <felix.riemann@sma.de>
> > > Reviewed-by: Andre Kalb <andre.kalb@sma.de>
> > > ---
> > >  drivers/net/can/c_can/c_can.c | 19 ++++++++++++++++++-
> > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/can/c_can/c_can.c
> > > b/drivers/net/can/c_can/c_can.c index 8e9f5620c9a2..0952ac0b9123
> > > 100644
> > > --- a/drivers/net/can/c_can/c_can.c
> > > +++ b/drivers/net/can/c_can/c_can.c
> > > @@ -1123,8 +1123,25 @@ static int c_can_poll(struct napi_struct *napi, int quota)
> > >  if (work_done < quota) {
> > >  napi_complete_done(napi, work_done);
> > >  /* enable all IRQs if we are not in bus off state */
> > > -if (priv->can.state != CAN_STATE_BUS_OFF)
> > > +if (priv->can.state != CAN_STATE_BUS_OFF) {
> > > +u32 ctrl;
> > >  c_can_irq_control(priv, true);
> > > +
> > > +/* There appears to be a race condition when the device
> > > + * enters bus off while interrupts are off or being
> > > + * re-enabled causing the bus off to get lost.
> > > + * This tries to avoid this condition.
> > > + */
> > > +ctrl = priv->read_reg(priv, C_CAN_CTRL_REG);
> > > +
> > > +if (ctrl & CONTROL_INIT) {
> > > +netdev_warn(dev, "lost bus off\n");
> > > +c_can_irq_control(priv, false);
> > > +/* Reschedule worker to handle bus off */
> > > +atomic_set(&priv->sie_pending, 1);
> > > +napi_reschedule(napi);
> > > +}
> > > +}
> > >  }
> > >
> > >  return work_done;
> > > --
> > > 2.26.0
> > >
> > ___________________________________________________
> >
> > SMA Solar Technology AG
> > Aufsichtsrat: Dr. Erik Ehrentraut (Vorsitzender)
> > Vorstand: Ulrich Hadding, Dr.-Ing. Juergen Reinert
> > Handelsregister: Amtsgericht Kassel HRB 3972
> > Sitz der Gesellschaft: 34266 Niestetal
> > USt-ID-Nr. DE 113 08 59 54
> > WEEE-Reg.-Nr. DE 95881150
> > ___________________________________________________
> ___________________________________________________
> 
> SMA Solar Technology AG
> Aufsichtsrat: Dr. Erik Ehrentraut (Vorsitzender)
> Vorstand: Ulrich Hadding, Dr.-Ing. Juergen Reinert
> Handelsregister: Amtsgericht Kassel HRB 3972
> Sitz der Gesellschaft: 34266 Niestetal
> USt-ID-Nr. DE 113 08 59 54
> WEEE-Reg.-Nr. DE 95881150
> ___________________________________________________
