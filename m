Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBDD3241FE
	for <lists+linux-can@lfdr.de>; Wed, 24 Feb 2021 17:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhBXQVQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 24 Feb 2021 11:21:16 -0500
Received: from mxcwn13.webd.pl ([194.181.228.69]:37062 "EHLO mxcwn13.webd.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232949AbhBXQU2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 24 Feb 2021 11:20:28 -0500
X-Greylist: delayed 17685 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Feb 2021 11:20:26 EST
Received: from wn13.int.webd ([192.168.101.113] helo=wn13.webd.pl)
        by mta01.webd.pl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <m.madej@xtrack.com>)
        id 1lEsHr-0005vz-9l
        for linux-can@vger.kernel.org; Wed, 24 Feb 2021 12:24:59 +0100
Received: from [192.168.101.231] (port=45408 helo=mta01.int.webd)
        by wn13.webd.pl with esmtp (Exim 4.93)
        (envelope-from <m.madej@xtrack.com>)
        id 1lEsHr-0005DL-76
        for linux-can@vger.kernel.org; Wed, 24 Feb 2021 12:24:59 +0100
X-Quarantine-ID: <7yOqngGKG_Gm>
X-Virus-Scanned: amavisd-new at mxwn13.webd.pl
Received: from wn13.webd.pl ([192.168.101.113])
        by mta01.int.webd (mxwn13.webd.pl [192.168.101.200]) (amavisd-new, port 10134)
        with ESMTP id 7yOqngGKG_Gm for <linux-can@vger.kernel.org>;
        Wed, 24 Feb 2021 12:24:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xtrack.com;
         s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UvujGglEUtXAHcPQWfT7nTB6HDaNso/Ri9rzb4oMUvE=; b=nGHo4sKex60knr2hiPRAgqlNf+
        j9oioqLl1zbk7Z+hqt5SieIEAKwUasGcTLUT/2fxeONQzlLCoRuKGtuztwExA5UlIbW3YWd2bDj08
        YBbZ4QOBMfJiO05L1tWCwoNojZNIbSuS4lkb2/FH5NSk28s4TOVORPW9Zj9efXh7W+GM4tCBxM2YE
        G+fPSGCTpLqHGccpSUMgHgnmZaz8RPzLEfjDfpAuWsPnvhSGGI4X44c9J/XQCDtgiXvESAJdHPxac
        iKsAnljz2Kpq3HjvkzW3ras5uo2p4SEHQ3yrUcy269gtSs8dII12No9XytaJRWz5YmQiHQ+kWxq+4
        epu3QBAw==;
Received: from [185.241.198.130] (port=56500 helo=[192.168.32.4])
        by wn13.webd.pl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <m.madej@xtrack.com>)
        id 1lEsHq-0005D2-Ui
        for linux-can@vger.kernel.org; Wed, 24 Feb 2021 12:24:58 +0100
To:     linux-can@vger.kernel.org
From:   Mariusz Madej <m.madej@xtrack.com>
Subject: m_can: a lot of 'Rx FIFO 0 Message Lost' in dmesg
Message-ID: <b4179765-d57b-991d-0baa-0270bdf6fd0b@xtrack.com>
Date:   Wed, 24 Feb 2021 12:24:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

I have a problem with m_can controller in my sama5d2 processor.
Under heavy can traffic it happens that my device starts to report (dmesg):

[   77.610000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost
[   77.620000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost
[   77.630000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost
[   77.630000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost
[   77.640000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost
[   77.640000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost
[   77.650000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost
[   77.660000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost
[   77.660000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost

what causes large load problem in my system.

I think I have a clue what is going on but my kernel knowledge is low so 
i want
You to tell me if I am right or not. So:

The only place in m_can.c file, where interrupt register is cleared is 
function
called when interrupt arrives

static irqreturn_t m_can_isr(int irq, void *dev_id)
{
.
.
         /* ACK all irqs */
         if (ir & IR_ALL_INT)
                 m_can_write(cdev, M_CAN_IR, ir);
.
.
}

But when we enter 'NAPI mode' in heavy load we are never get to this 
function
until load gets lower and interrupts are enabled again. In this situation,
this code:

static int m_can_do_rx_poll(struct net_device *dev, int quota)
{
         struct m_can_classdev *cdev = netdev_priv(dev);
         u32 pkts = 0;
         u32 rxfs;

         rxfs = m_can_read(cdev, M_CAN_RXF0S);
         if (!(rxfs & RXFS_FFL_MASK)) {
                 netdev_dbg(dev, "no messages in fifo0\n");
                 return 0;
         }

         while ((rxfs & RXFS_FFL_MASK) && (quota > 0)) {
                 if (rxfs & RXFS_RFL)
                         netdev_warn(dev, "Rx FIFO 0 Message Lost\n");

                 m_can_read_fifo(dev, rxfs);

                 quota--;
                 pkts++;
                 rxfs = m_can_read(cdev, M_CAN_RXF0S);
         }

         if (pkts)
                 can_led_event(dev, CAN_LED_EVENT_RX);

         return pkts;
}

will always have (rxfs & RXFS_RFL) == true until interrupt are enabled 
again.
That is why we got so many messages in a row for so long time. So clearing
RXFS_RFL bit after warning is issued could be a solution.

Can You tell me if I am right?
