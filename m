Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3051FB101
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2020 14:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgFPMm5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Jun 2020 08:42:57 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:50228 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgFPMm5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Jun 2020 08:42:57 -0400
X-ASG-Debug-ID: 1592311374-0a881821b611f0a30001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be ([213.219.130.186]) by relay-b03.edpnet.be with ESMTP id iewaZb1nV14E2qvb; Tue, 16 Jun 2020 14:42:54 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: UNKNOWN[213.219.130.186]
X-Barracuda-Apparent-Source-IP: 213.219.130.186
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 776B2F5CEB8;
        Tue, 16 Jun 2020 14:42:47 +0200 (CEST)
Date:   Tue, 16 Jun 2020 14:42:43 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Felix Riemann <Felix.Riemann@sma.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Andre Kalb <Andre.Kalb@sma.de>
Subject: Re: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
 disabled
Message-ID: <20200616124243.GA18169@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
 disabled
Mail-Followup-To: Felix Riemann <Felix.Riemann@sma.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Andre Kalb <Andre.Kalb@sma.de>
References: <20200330070203.GE22500@x1.vandijck-laurijssen.be>
 <AM0PR04MB54271EA5CC205263750BDBD288CB0@AM0PR04MB5427.eurprd04.prod.outlook.com>
 <20200429084733.GA27733@x1.vandijck-laurijssen.be>
 <20200429090618.GB27733@x1.vandijck-laurijssen.be>
 <AM0PR04MB6273640802E04C4009CE5BC588830@AM0PR04MB6273.eurprd04.prod.outlook.com>
 <20200612071044.GA25294@x1.vandijck-laurijssen.be>
 <20200612074253.GB25294@x1.vandijck-laurijssen.be>
 <AM0PR04MB62731627E4FC7368DB5051D4889C0@AM0PR04MB6273.eurprd04.prod.outlook.com>
 <20200615153109.GB28894@x1.vandijck-laurijssen.be>
 <AM0PR04MB62734DA80CB35517656041FE889D0@AM0PR04MB6273.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM0PR04MB62734DA80CB35517656041FE889D0@AM0PR04MB6273.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: UNKNOWN[213.219.130.186]
X-Barracuda-Start-Time: 1592311374
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2265
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6630 1.0000 1.1058
X-Barracuda-Spam-Score: 1.11
X-Barracuda-Spam-Status: No, SCORE=1.11 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.82589
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 16 jun 2020 09:51:00 +0000, Felix Riemann wrote:
> Hi Kurt,
> 
> > -----Original Message-----
> > From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> > Sent: Monday, June 15, 2020 5:31 PM
> > Subject: Re: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
> > disabled
> >
> > On ma, 15 jun 2020 11:11:17 +0000, Felix Riemann wrote:
> > >
> > > Hi Kurt,
> > >
> > > see below.
> > >
> > > > -----Original Message-----
> > > >
> > > > Hi Felix,
> > > >
> > > > Next question comes up.
> > > > See inline.
> > > >
> > > > On vr, 12 jun 2020 09:10:44 +0200, Kurt Van Dijck wrote:
> > > > > Thanks for verifying,
> > > > >
> > > > > I'll take a look how that can happen.
> > > > >
> > > > > I think packet loss is better (less packets lost) than before.
> > > > >
> > > > > Kurt
> > > > >
> > > > > On wo, 10 jun 2020 08:08:28 +0000, Felix Riemann wrote:
> > > > > > Hi Kurt,
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > >
> > > > > > > I have the impression that the recv path is covered, at least
> > > > > > > the null ptr would have caused issued earlier already.
> > > > > > > Would the problem arise in c_can_do_tx fetching a NULL echo_skb?
> > > > > >
> > > > > > It really looks like it.
> > > > > >
> > > > > > Adding a BUG_ON to the loop in c_can_do_tx triggers with a NULL
> > > > > > skb
> > > > returned by __can_get_echo_skb().
> > > > > >
> > > > > > For testing I replaced the BUG_ON with a check that skips the
> > > > > > skb if that
> > > > happens (not sure if that would be a valid fix in that place):
> > > > > >
> > > > > > while ((obj = c_can_ffs64(pend))) { pend &= ~((u64)1 << (obj -
> > > > > > 1)); c_can_inval_tx_object(dev, IF_RX, obj); idx = obj -
> > > > > > priv->obj.send_frst; skb = __can_get_echo_skb(dev, idx, &len);
> > > > > > if(!skb)
> > > >
> > > > It would be interesting to know idx and priv->tx_active here.
> > >
> > > That's the statistic over about 1600 lines I captured. First number is number
> > of occurrences:
> >
> > just double-check:
> > These are all when __can_get_echo_skb returned NULL?
> 
> Yes, that's correct. The printout occurs directly before it skips to the next item in the loop.

thanks.
