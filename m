Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5A7590EB4
	for <lists+linux-can@lfdr.de>; Fri, 12 Aug 2022 12:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbiHLKIB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Aug 2022 06:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiHLKIA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Aug 2022 06:08:00 -0400
Received: from mailgw.felk.cvut.cz (mailgw.felk.cvut.cz [147.32.82.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4439753C
        for <linux-can@vger.kernel.org>; Fri, 12 Aug 2022 03:07:58 -0700 (PDT)
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id 3BA5C30B2962;
        Fri, 12 Aug 2022 12:07:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        cmp.felk.cvut.cz; h=cc:cc:content-transfer-encoding:content-type
        :content-type:date:from:from:in-reply-to:message-id:mime-version
        :references:reply-to:subject:subject:to:to; s=felkmail; bh=zXXAS
        zqSE68QW0896Hw7/O6PmfsghgMxutcH+SF/HrA=; b=I/ee2haKDsj2oNNNv6VkH
        za3ugdnInU4Nrydvg3PLU/ptBKifAz/gIudbXRHY1Di6PLUMiOCobsQfL5qAk+3W
        YZ4CIyE5khg3UPP5rrzpabjgrPjaotbVb3ZtuIQlwBcqJIz55K0gGEn3ChTcTwbZ
        P6vLfP6UrJwo7zSvRpufMCkxuLNkF75eO7Giq6mSUzu6D6Gl8puL4vKn1cSMvbRt
        JGUW+fCzE+/XGhsP8gW6BGL6meHU78XhJYS9648PrmnLr95ajDJkBzMi02W3RQgg
        yipdN7OZ6RXQTP4wnTF4BQzt5FSPb2eu3pj7WB7+7JeplIMg6iIhQQrMwMo4z7/V
        w==
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id F152030B295A;
        Fri, 12 Aug 2022 12:07:54 +0200 (CEST)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 27CA7sNG015257;
        Fri, 12 Aug 2022 12:07:54 +0200
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 27CA7seM015255;
        Fri, 12 Aug 2022 12:07:54 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     "Marc Kleine-Budde" <mkl@pengutronix.de>,
        Matej Vasilevski <matej.vasilevski@gmail.com>,
        Pavel Hronek <hronepa1@fel.cvut.cz>
Subject: Re: [PATCH v8 3/7] can: ctucanfd: add support for CTU CAN FD open-source IP core - bus independent part.
Date:   Fri, 12 Aug 2022 12:07:48 +0200
User-Agent: KMail/1.9.10
Cc:     linux-can@vger.kernel.org,
        Marin Jerabek <martin.jerabek01@gmail.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Jiri Novak <jnovak@fel.cvut.cz>,
        Jaroslav Beran <jara.beran@gmail.com>,
        Petr Porazil <porazil@pikron.com>, Pavel Machek <pavel@ucw.cz>
References: <cover.1647904780.git.pisa@cmp.felk.cvut.cz> <1906e4941560ae2ce4b8d181131fd4963aa31611.1647904780.git.pisa@cmp.felk.cvut.cz> <20220810200043.pcpkbiq7f47cmi6t@pengutronix.de>
In-Reply-To: <20220810200043.pcpkbiq7f47cmi6t@pengutronix.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202208121207.48319.pisa@cmp.felk.cvut.cz>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

thanks for interrest to clean the code.

On Wednesday 10 of August 2022 22:00:43 Marc Kleine-Budde wrote:
> I was about to convert these macros into static inline bool functions
> and thinking the naming can be improved a bit:
>
> On 22.03.2022 00:32:30, Pavel Pisa wrote:
> > +#define CTU_CAN_FD_TXTNF(priv) (!!FIELD_GET(REG_STATUS_TXNF,
> > ctucan_read32(priv, CTUCANFD_STATUS)))
> > +#define CTU_CAN_FD_ENABLED(priv) 
> > (!!FIELD_GET(REG_MODE_ENA, ctucan_read32(priv, CTUCANFD_MODE)))
>
> [...]
>
> The common prefix for functions seems to be "ctucan_", so if I convert
> CTU_CAN_FD_ENABLED -> ctucan_fd_enabled() the unfamiliar reader might
> think this functions tests if the controller is in FD mode.
>
> As far as I understand the code, the test is if the controller is
> enabled at all. This is done via the ctucan_chip_start() function and
> undone via ctucan_chip_stop(). So a better function names might be:
> - ctucan_chip_started()
> - ctucan_chip_is_started()
> - ctucan_chip_enabled()
> - ctucan_chip_is_enabled()

All are understandable.

When I think about meaning then I have come to these two

  ctucan_operation_is_enabled()

  ctucan_communication_enabled()

As for TXNF, it meaning is TX buffers are not full or there
is at least one buffer available to fill/prepare another Tx
request. So some examples of descriptive names

   ctucan_empty_txbuf_available()

or if negated then

   ctucan_no_empty_txbuf()

If you want to clear that yourself then go on, you have my ACK
in advance, I am not available on Internet for next week.

You can left it to the Matej Vasilevski prepared patches
series. I hope he finds some time to prepare it to mainline
his thesis work. But if he does not have time I takeover
results of his work and attempt to form his path and add some
mine followups (clock etc..) to include them in network next
during September...

As for the basic driver functionality testing, it is possible
with mainline QEMU easily

  https://www.qemu.org/docs/master/system/devices/can.html

The setup to run commits against ARM kernel environment automatically
on Zynq HW is available but requires access rights to our GitLab
repositories and actual kernel version is 

  5.10.19-rt32-00004-gd19e6d98b097 #1 SMP PREEMPT_RT

I can add access to you to our GitLab but I do not expect that
is is of much interrest. I plan to update base but it is used
on more education and other systems, so we want to keep wider
compatability.

Matej Vasilevski has HW for local testing and tests on mainline.
Pavel Hronek will continue on his work with goal to have another
setups with automatic testing, including latencies which
would follow actual mainline. Ideally in cooperation with OSADL
to be used on systems with other controllers on hardware
available there. But that is longer goal and we look for OSADL
members who have interrest for such continuous RT and CAN latencies
QA farm testing.

> > +/**
> > + * ctucan_set_btr() - Sets CAN bus bit timing in CTU CAN FD
> > + * @ndev:	Pointer to net_device structure
> > + * @bt:		Pointer to Bit timing structure
> > + * @nominal:	True - Nominal bit timing, False - Data bit timing
> > + *
> > + * Return: 0 - OK, -%EPERM if controller is enabled
> > + */
> > +static int ctucan_set_btr(struct net_device *ndev, struct can_bittiming
> > *bt, bool nominal) +{
> > +	struct ctucan_priv *priv = netdev_priv(ndev);
> > +	int max_ph1_len = 31;
> > +	u32 btr = 0;
> > +	u32 prop_seg = bt->prop_seg;
> > +	u32 phase_seg1 = bt->phase_seg1;
> > +
> > +	if (CTU_CAN_FD_ENABLED(priv)) {
> > +		netdev_err(ndev, "BUG! Cannot set bittiming - CAN is enabled\n");
>
> I would want to replace "CAN" with "Chip" or "Controller".

May it be

  BUG! Cannot set bittiming when operation is enabled

> > +		return -EPERM;
> > +	}
> > +
> > +	if (nominal)
> > +		max_ph1_len = 63;
> > +
> > +	/* The timing calculation functions have only constraints on tseg1,
> > which is prop_seg + +	 * phase1_seg combined. tseg1 is then split in half
> > and stored into prog_seg and phase_seg1. +	 * In CTU CAN FD, PROP is 6/7
> > bits wide but PH1 only 6/5, so we must re-distribute the +	 * values
> > here.
> > +	 */
> > +	if (phase_seg1 > max_ph1_len) {
> > +		prop_seg += phase_seg1 - max_ph1_len;
> > +		phase_seg1 = max_ph1_len;
> > +		bt->prop_seg = prop_seg;
> > +		bt->phase_seg1 = phase_seg1;
> > +	}
> > +
> > +	if (nominal) {
> > +		btr = FIELD_PREP(REG_BTR_PROP, prop_seg);
> > +		btr |= FIELD_PREP(REG_BTR_PH1, phase_seg1);
> > +		btr |= FIELD_PREP(REG_BTR_PH2, bt->phase_seg2);
> > +		btr |= FIELD_PREP(REG_BTR_BRP, bt->brp);
> > +		btr |= FIELD_PREP(REG_BTR_SJW, bt->sjw);
> > +
> > +		ctucan_write32(priv, CTUCANFD_BTR, btr);
> > +	} else {
> > +		btr = FIELD_PREP(REG_BTR_FD_PROP_FD, prop_seg);
> > +		btr |= FIELD_PREP(REG_BTR_FD_PH1_FD, phase_seg1);
> > +		btr |= FIELD_PREP(REG_BTR_FD_PH2_FD, bt->phase_seg2);
> > +		btr |= FIELD_PREP(REG_BTR_FD_BRP_FD, bt->brp);
> > +		btr |= FIELD_PREP(REG_BTR_FD_SJW_FD, bt->sjw);
> > +
> > +		ctucan_write32(priv, CTUCANFD_BTR_FD, btr);
> > +	}
> > +
> > +	return 0;
> > +}
>
> [...]
>
> > +/**
> > + * ctucan_start_xmit() - Starts the transmission
> > + * @skb:	sk_buff pointer that contains data to be Txed
> > + * @ndev:	Pointer to net_device structure
> > + *
> > + * Invoked from upper layers to initiate transmission. Uses the next
> > available free TXT Buffer and + * populates its fields to start the
> > transmission.
> > + *
> > + * Return: %NETDEV_TX_OK on success, %NETDEV_TX_BUSY when no free TXT
> > buffer is available, + *         negative return values reserved for
> > error cases
> > + */
> > +static netdev_tx_t ctucan_start_xmit(struct sk_buff *skb, struct
> > net_device *ndev) +{
> > +	struct ctucan_priv *priv = netdev_priv(ndev);
> > +	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
> > +	u32 txtb_id;
> > +	bool ok;
> > +	unsigned long flags;
> > +
> > +	if (can_dropped_invalid_skb(ndev, skb))
> > +		return NETDEV_TX_OK;
> > +
> > +	if (unlikely(!CTU_CAN_FD_TXTNF(priv))) {
>
> I'm also looking for nicer names for "CTU_CAN_FD_TXTNF".
> What about ctucan_txt_buffer_full() and reverse the logic?

possible as well

> > +		netif_stop_queue(ndev);
> > +		netdev_err(ndev, "BUG!, no TXB free when queue awake!\n");
> > +		return NETDEV_TX_BUSY;
> > +	}
>
> Marc

Best wishes,

                Pavel
-- 
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

