Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2988F1F74A1
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2020 09:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgFLHad (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Jun 2020 03:30:33 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:33776 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgFLHad (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Jun 2020 03:30:33 -0400
X-Greylist: delayed 1177 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2020 03:30:31 EDT
X-ASG-Debug-ID: 1591945852-0a7ff575aa100f3a0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be ([213.219.130.186]) by relay-b01.edpnet.be with ESMTP id z3DpjmiNR1u2Pl6t; Fri, 12 Jun 2020 09:10:52 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: UNKNOWN[213.219.130.186]
X-Barracuda-Apparent-Source-IP: 213.219.130.186
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 5D0CBF515C4;
        Fri, 12 Jun 2020 09:10:46 +0200 (CEST)
Date:   Fri, 12 Jun 2020 09:10:44 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Felix Riemann <Felix.Riemann@sma.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Andre Kalb <Andre.Kalb@sma.de>
Subject: Re: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
 disabled
Message-ID: <20200612071044.GA25294@x1.vandijck-laurijssen.be>
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
 <20200429084733.GA27733@x1.vandijck-laurijssen.be>
 <20200429090618.GB27733@x1.vandijck-laurijssen.be>
 <AM0PR04MB6273640802E04C4009CE5BC588830@AM0PR04MB6273.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM0PR04MB6273640802E04C4009CE5BC588830@AM0PR04MB6273.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: UNKNOWN[213.219.130.186]
X-Barracuda-Start-Time: 1591945852
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1596
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5003 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.82495
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thanks for verifying,

I'll take a look how that can happen.

I think packet loss is better (less packets lost) than before.

Kurt

On wo, 10 jun 2020 08:08:28 +0000, Felix Riemann wrote:
> Hi Kurt,
> 
> > -----Original Message-----
> >
> > I have the impression that the recv path is covered, at least the null ptr would
> > have caused issued earlier already.
> > Would the problem arise in c_can_do_tx fetching a NULL echo_skb?
> 
> It really looks like it.
> 
> Adding a BUG_ON to the loop in c_can_do_tx triggers with a NULL skb returned by __can_get_echo_skb().
> 
> For testing I replaced the BUG_ON with a check that skips the skb if that happens (not sure if that would be a valid fix in that place):
> 
> while ((obj = c_can_ffs64(pend))) {
> pend &= ~((u64)1 << (obj - 1));
> c_can_inval_tx_object(dev, IF_RX, obj);
> idx = obj - priv->obj.send_frst;
> skb = __can_get_echo_skb(dev, idx, &len);
> if(!skb)
> continue;
> can_rx_offload_irq_receive_skb(&priv->offload, skb);
> bytes += len;
> pkts++;
> }
> 
> So far it got through the night without crashing or deadlocking, but I can't really tell if we are missing pakets though.
> 
> Regards,
> 
> Felix
> ___________________________________________________
> 
> SMA Solar Technology AG
> Aufsichtsrat: Uwe Kleinkauf (Vorsitzender)
> Vorstand: Ulrich Hadding, Dr.-Ing. Juergen Reinert
> Handelsregister: Amtsgericht Kassel HRB 3972
> Sitz der Gesellschaft: 34266 Niestetal
> USt-ID-Nr. DE 113 08 59 54
> WEEE-Reg.-Nr. DE 95881150
> ___________________________________________________
