Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121411BD789
	for <lists+linux-can@lfdr.de>; Wed, 29 Apr 2020 10:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgD2Irr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 29 Apr 2020 04:47:47 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:48145 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2Irq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 29 Apr 2020 04:47:46 -0400
X-ASG-Debug-ID: 1588150055-0a7b8d210f522260001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.74.adsl.dyn.edpnet.net [77.109.105.74]) by relay-b02.edpnet.be with ESMTP id 4X54qN5ToIGIyC3B; Wed, 29 Apr 2020 10:47:35 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Apparent-Source-IP: 77.109.105.74
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 96EDBE8F8F5;
        Wed, 29 Apr 2020 10:47:35 +0200 (CEST)
Date:   Wed, 29 Apr 2020 10:47:33 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Felix Riemann <Felix.Riemann@sma.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Andre Kalb <Andre.Kalb@sma.de>
Subject: Re: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
 disabled
Message-ID: <20200429084733.GA27733@x1.vandijck-laurijssen.be>
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
 <20200330070203.GE22500@x1.vandijck-laurijssen.be>
 <AM0PR04MB54271EA5CC205263750BDBD288CB0@AM0PR04MB5427.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM0PR04MB54271EA5CC205263750BDBD288CB0@AM0PR04MB5427.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Start-Time: 1588150055
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 10585
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5607 1.0000 0.7500
X-Barracuda-Spam-Score: 1.25
X-Barracuda-Spam-Status: No, SCORE=1.25 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_RULE7568M, INFO_TLD
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81506
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 INFO_TLD               URI: Contains an URL in the INFO top-level domain
        0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

On ma, 30 mrt 2020 17:30:08 +0000, Felix Riemann wrote:
> Hi Kurt,
> 
> tried to give it a try. However, after starting a few (4 - 5) cangen  instances to increase bus load it panics:

It would be more helpful if you had a verbose stacktrace.

Kurt

> 
> [  207.259295] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [  207.267433] pgd = d2bd4866
> [  207.270153] [00000000] *pgd=8ca25831, *pte=00000000, *ppte=00000000
> [  207.276469] Internal error: Oops: 817 [#1] PREEMPT ARM
> [  207.281633] Modules linked in: cfg80211 rfkill lm75 musb_dsps musb_hdrc usbcore phy_am335x phy_generic usb_common phy_am335x_control gpio_keys xt_owner iptable_filter ip_tables can_raw
> [  207.298189] CPU: 0 PID: 782 Comm: cangen Not tainted 5.5.11-00013-gcdf175eb0ffc #7
> [  207.305793] Hardware name: Generic AM33XX (Flattened Device Tree)
> [  207.311942] PC is at can_rx_offload_irq_receive_skb+0x54/0x78
> [  207.317722] LR is at c_can_isr+0x52c/0x5b0
> [  207.321838] pc : [<c04856f4>]    lr : [<c04875f8>]    psr: 80070193
> [  207.328133] sp : cde6fd30  ip : 00000008  fp : cf4ec5c8
> [  207.333383] r10: 00000000  r9 : 00000000  r8 : cf4ec4e0
> [  207.338633] r7 : 00000001  r6 : 00000000  r5 : 00000039  r4 : cf4ec000
> [  207.345192] r3 : cf4ec5c8  r2 : cf4ec5dc  r1 : 00000000  r0 : cf4ec5dc
> [  207.351752] Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [  207.359010] Control: 10c5387d  Table: 8cb50019  DAC: 00000051
> [  207.364785] Process cangen (pid: 782, stack limit = 0x7ef64b0d)
> [  207.370734] Stack: (0xcde6fd30 to 0xcde70000)
> [  207.375116] fd20:                                     00000000 cf4ec000 00000000 00000000
> [  207.383341] fd40: cde6fd7f 8d12c45f cd82ed80 cc864c80 cf3a9310 00000030 00000001 ffffe000
> [  207.391566] fd60: cf3a9300 cde6fda0 00000000 c0165450 cf3a9300 cde6fda0 00010002 c0a04248
> [  207.399790] fd80: cf3a9310 cf3a9300 00000001 00000000 cde6e000 8ec8018f 000000e8 c01655f4
> [  207.408014] fda0: 00000000 8d12c45f cf3a9300 cf3a9310 cf01f400 c01656a4 cf3a9300 cf3a9310
> [  207.416239] fdc0: cf01f400 c0169520 00000000 00000000 cf01f400 c0164720 00000000 c0164dac
> [  207.424463] fde0: c01128c4 20070113 ffffffff cde6fe2c 00000000 c0101a8c 00020837 cfecd200
> [  207.432687] fe00: cfcb9000 00214200 8ec8018f 0000ec80 00000000 cfecd200 00000000 00000000
> [  207.440911] fe20: 8ec8018f 000000e8 20070113 cde6fe48 00020837 c01128c4 20070113 ffffffff
> [  207.449136] fe40: 00000051 bf000000 8ec8018f cca261ac 00000000 c0203830 cde6fee4 cf79e0b0
> [  207.457359] fe60: 00000000 c0206358 cfecd200 00000001 cde6fee4 cdcba300 ce38e188 000000ec
> [  207.465584] fe80: c0a04248 c01de0d0 00023b20 ce38e18c 000000e8 00280000 ce37e720 00000000
> [  207.473807] fea0: 00000000 8d12c45f 00000011 00000000 000000ec c0a04248 b6e61000 00000040
> [  207.482032] fec0: 000000dd cc8b7000 cc8b703c c0206b80 c0a04248 00000000 cdcba840 00000010
> [  207.490256] fee0: 00000000 cf79e0b0 00000054 00100cca 000000de b6e6b000 ccb52db8 ccb52db8
> [  207.498479] ff00: 00000000 00000000 00000000 00000000 cca261ac cc8b703c 00000000 8d12c45f
> [  207.506704] ff20: ce694570 cde6ffb0 b6e61de4 cf79e0b0 00000054 cd944000 cc8b7000 80000007
> [  207.514928] ff40: cc8b703c c0110c44 cdcba840 00000010 00000010 c022c9f4 00000000 00000010
> [  207.523152] ff60: cdcba840 00000007 c0a08e38 b6e61de4 cde6ffb0 10c53c7d 00000000 00023b20
> [  207.531375] ff80: 00023b20 c0110f94 00000000 00000010 00000000 00000004 c0101204 b6e61de4
> [  207.539599] ffa0: 60070010 ffffffff 10c5387d c01020c8 bea8fbc8 00000000 00000010 00000000
> [  207.547822] ffc0: 00000000 00000010 00000000 00000003 00000000 00000000 00023b20 00023b20
> [  207.556047] ffe0: b6e61de4 bea8fb78 00011454 b6e61de4 60070010 ffffffff 00000000 00000000
> [  207.564287] [<c04856f4>] (can_rx_offload_irq_receive_skb) from [<cf4ec000>] (0xcf4ec000)
> [  207.572428] Code: e58430e8 e8bd8010 e5932018 e2830014 (e5810000)
> [  207.578557] ---[ end trace 67a8f60eda872c72 ]---
> [  207.583199] Kernel panic - not syncing: Fatal exception in interrupt
> 
> I also noticed two things while building the patchset.
> The GPL export of can_rx_offload_irq_receive_skb uses the wrong name in the second patch and patch 5 prevents the c_can driver from being built as a module as it references the unexported __can_get_echo_skb function.
> 
> Regards,
> 
> Felix
> 
> 
> > -----Original Message-----
> > From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> > Sent: Monday, March 30, 2020 9:02 AM
> >
> > On vr, 27 mrt 2020 10:09:03 +0000, Felix Riemann wrote:
> > > Is it this one?
> > > https://marc.info/?l=linux-can&m=157683579518282
> >
> > yes
> >
> > >
> > > It seems to be missing patch 6 in the series.
> >
> > you can get there via
> > https://github.com/kurt-vd/linux, branch c_can-next
> >
> > Kurt
> >
> > >
> > > Regards,
> > > Felix
> > >
> > > -----Original Message-----
> > > From: Kurt Van Dijck
> > > Sent: Thursday, March 26, 2020 8:39 PM
> > >
> > > Interesting topic.
> > >
> > > After the bus-off problem, I also attacked the overflow problems. No
> > > idea why this patch series got stalled. I activated the complete 64
> > > message buffers of the D_CAN hardware (only 64 of the 128 being
> > > present in the IP for some reason I don't know) and modified the IRQ
> > > to use rx-offload. That may affect the circumstances under load, I admit.
> > >
> > > Whould you mind trying that series, just for reference, in your setup?
> > > If your hypothesis is right, my observations do not survive your
> > > busload.
> > >
> > > Kind regards,
> > > Kurt
> > >
> > > On do, 26 mrt 2020 14:49:23 +0000, Felix Riemann wrote:
> > > > Hi Kurt,
> > > >
> > > > yes that would be 3cb3eaac52c0f145d895f4b6c22834d5f02b8569.
> > > >
> > > > I tried your patch as well, since the description matched the problem pretty
> > well. However, I could still produce the hang on our board (based on AM3352)
> > especially if the bus off occurs while the bus load is very high.
> > > >
> > > > What I could see was the worker being triggered by the interrupt with the
> > bus being in passive mode. When the worker then re-enabled the interrupt the
> > hardware had already entered init mode due to the bus-off but nor would it
> > trigger again nor would the interrupt register indicate a pending IRQ. The status
> > register also indicates an error (LEC != 0x7).
> > > >
> > > > A first attempt to fix/workaround this placed the check just before the
> > worker re-enables the interrupts. But even this setup could reproduce the
> > problem, although it took longer to do so.  So the timing around enabling the
> > interrupts seems to matter here. Actually, adding a printout at the top of the
> > worker where your patch checks the value of the sie_pending atomic seems to
> > increase the chances of making it happen on my board, but that's just a feeling I
> > got while cleaning up my patch.
> > > >
> > > > Regards,
> > > >
> > > > Felix
> > > >
> > > > -----Original Message-----
> > > > From: Kurt Van Dijck <mailto:dev.kurt@vandijck-laurijssen.be>
> > > > Sent: Thursday, March 26, 2020 2:40 PM
> > > >
> > > > This patch looks very familiar.
> > > > I tried this 6 months ago, when I got a setup where I could reproduce this
> > within minutes.
> > > >
> > > > This patch didn't solve my problem, and I fixed my problem with reading the
> > ISR register only once in the IRQ, and _not_ 2nd time in napi handler.
> > > > Reading the ISR in C_CAN is consuming the info, so unless the there is more
> > state to clear (such as received message buffers), the interrupt cause is assumed
> > to be known, and the C_CAN proceeds to the next interrupt cause.
> > > > I've not experienced a single problem since, where before the fix, I'd
> > experience a few occurances every month.
> > > > We have an am3358 (beaglebone-like hardware).
> > > >
> > > > I believe I submitted a patch for that.
> > > >
> > > > Re-scheduling the napi is a workaround, IMHO.
> > > >
> > > > Kurt
> > > >
> > > > On do, 26 mrt 2020 11:43:18 +0100, Felix Riemann wrote:
> > > > > There are appears to be a race condition where interrupts caused
> > > > > by bus offs get lost if it occurs while interrupts are disabled or
> > > > > being re-enabled.
> > > > >
> > > > > This tries to avoid the deadlock by rescheduling the NAPI worker
> > > > > to handle the bus-off condition.
> > > > >
> > > > > Signed-off-by: Felix Riemann <mailto:felix.riemann@sma.de>
> > > > > Reviewed-by: Andre Kalb <mailto:andre.kalb@sma.de>
> > > > > ---
> > > > >  drivers/net/can/c_can/c_can.c | 19 ++++++++++++++++++-
> > > > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/net/can/c_can/c_can.c
> > > > > b/drivers/net/can/c_can/c_can.c index 8e9f5620c9a2..0952ac0b9123
> > > > > 100644
> > > > > --- a/drivers/net/can/c_can/c_can.c
> > > > > +++ b/drivers/net/can/c_can/c_can.c
> > > > > @@ -1123,8 +1123,25 @@ static int c_can_poll(struct napi_struct
> > > > > *napi, int quota)  if (work_done < quota) {
> > > > > napi_complete_done(napi, work_done);
> > > > >  /* enable all IRQs if we are not in bus off state */ -if
> > > > > (priv->can.state != CAN_STATE_BUS_OFF)
> > > > > +if (priv->can.state != CAN_STATE_BUS_OFF) {
> > > > > +u32 ctrl;
> > > > >  c_can_irq_control(priv, true);
> > > > > +
> > > > > +/* There appears to be a race condition when the device
> > > > > + * enters bus off while interrupts are off or being
> > > > > + * re-enabled causing the bus off to get lost.
> > > > > + * This tries to avoid this condition.
> > > > > + */
> > > > > +ctrl = priv->read_reg(priv, C_CAN_CTRL_REG);
> > > > > +
> > > > > +if (ctrl & CONTROL_INIT) {
> > > > > +netdev_warn(dev, "lost bus off\n"); c_can_irq_control(priv,
> > > > > +false);
> > > > > +/* Reschedule worker to handle bus off */
> > > > > +atomic_set(&priv->sie_pending, 1); napi_reschedule(napi); } }
> > > > >  }
> > > > >
> > > > >  return work_done;
> > > > > --
> > > > > 2.26.0
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
