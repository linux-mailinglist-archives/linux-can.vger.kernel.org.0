Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D1B326B96
	for <lists+linux-can@lfdr.de>; Sat, 27 Feb 2021 05:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhB0Eqs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Feb 2021 23:46:48 -0500
Received: from mxwn13.webd.pl ([194.181.228.67]:52295 "EHLO mxwn13.webd.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229795AbhB0Eqr (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 26 Feb 2021 23:46:47 -0500
X-Greylist: delayed 2550 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Feb 2021 23:46:43 EST
Received: from wn13.int.webd ([192.168.101.113] helo=wn13.webd.pl)
        by mta01.webd.pl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <mariusz.madej@xtrack.com>)
        id 1lFqpA-0002fg-3U; Sat, 27 Feb 2021 05:03:24 +0100
Received: from [192.168.101.231] (port=38386 helo=mta01.int.webd)
        by wn13.webd.pl with esmtp (Exim 4.93)
        (envelope-from <mariusz.madej@xtrack.com>)
        id 1lFqp9-0008OD-VT; Sat, 27 Feb 2021 05:03:23 +0100
X-Quarantine-ID: <xGQNV92m42CQ>
X-Virus-Scanned: amavisd-new at mxwn13.webd.pl
Received: from wn13.webd.pl ([192.168.101.113])
        by mta01.int.webd (mxwn13.webd.pl [192.168.101.200]) (amavisd-new, port 10134)
        with ESMTP id xGQNV92m42CQ; Sat, 27 Feb 2021 05:03:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xtrack.com;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Mfps4u+b9Jhg8JCS6rdyt4ryBICe3YrINKfFonXomgY=; b=krtKdS39LXlKkIheVHm6gohIHu
        K0ArzN0+5V6FqRZhsTRgSDGDwre1hv+i3P5ylAft/DvTzOmXTvFbseKglurWa10BPJBDZyiy8VToM
        +CVD8KdgdEiPR9P037yszeH3aauqs9EWyXFzzy5Nmqo0B/oTXlby4WgK6jmfbTH6yWNED8TswFFji
        xH+r8Vk9s4l75XwX1Pk14aZ3d0/TCdVJGG36Wir1xCP+PqcX9huYs+6NY1J0CvD/cXmHM2EsVfPhg
        nbQAip+KRsRQ/33fVqkUfgdMEBttbmEQY8WMvqRMpU5L1cGpI1EBXplth/7FuZa08YmqUOBWXc/3i
        x0cFUQgA==;
Received: from [185.241.198.130] (port=57272 helo=[192.168.32.4])
        by wn13.webd.pl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mariusz.madej@xtrack.com>)
        id 1lFqp1-0008N9-HS; Sat, 27 Feb 2021 05:03:15 +0100
Subject: Re: m_can: a lot of 'Rx FIFO 0 Message Lost' in dmesg
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <PR3PR05MB7212376CDA795770B7E625E6809F9@PR3PR05MB7212.eurprd05.prod.outlook.com>
 <20210226133702.echxlob5z4pj5ptc@bigthink>
From:   Mariusz Madej <mariusz.madej@xtrack.com>
Message-ID: <d0ebed81-3f7a-1e82-e16b-85e242d1ddca@xtrack.com>
Date:   Sat, 27 Feb 2021 05:03:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20210226133702.echxlob5z4pj5ptc@bigthink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2/26/21 2:37 PM, Torin Cooper-Bennun wrote

>> The only place in m_can.c file, where interrupt register is cleared is function
>> called when interrupt arrives
>>
>> static irqreturn_t m_can_isr(int irq, void *dev_id)
>> {
>> .
>> .
>>          /* ACK all irqs */
>>          if (ir & IR_ALL_INT)
>>                  m_can_write(cdev, M_CAN_IR, ir);
>> .
>> .
>> }
>>
>> But when we enter 'NAPI mode' in heavy load we are never get to this function
>> until load gets lower and interrupts are enabled again. In this situation,
>> this code:
> The m_can driver handles the IRQ by offloading the RX to a NAPI queue,
> so the RX procedure is deferred, and is scheduled to happen at a
> (slightly) later time. As far as I understand it, interrupts are not
> disabled at any point.

Interupts are disabled in m_can_isr function:

if ((ir & IR_RF0N) || (ir & IR_ERR_ALL_30X)) {
         cdev->irqstatus = ir;
         m_can_disable_all_interrupts(cdev);    <--------HERE
         if (!cdev->is_peripheral)
                 napi_schedule(&cdev->napi);
         else
                 m_can_rx_peripheral(dev);

}

and they are enabled conditionaly in function:

static int m_can_poll(struct napi_struct *napi, int quota)
{
         struct net_device *dev = napi->dev;
         struct m_can_classdev *cdev = netdev_priv(dev);
         int work_done;

         work_done = m_can_rx_handler(dev, quota);
         if (work_done < quota) {
                 napi_complete_done(napi, work_done);
                 m_can_enable_all_interrupts(cdev); <---- HERE
         }

         return work_done;
}

so if work_done==quota(64) napi will schedule next receiving instead
of enabling interrupts. That is why i wrote that in my condition i dont get
to m_can_isr function and message lost interrupt is not cleared. As a result
my device enters to this function:

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

With RXFS_RFL==true and 64 messages to be read, that is why i have 64 warnings
in a row.
Those warnings take cpu time, and in this time fifo is full again so
function m_can_poll does not enable interrupts again, and so on...

>> That is why we got so many messages in a row for so long time. So clearing
>> RXFS_RFL bit after warning is issued could be a solution.
> RXFS_RFL is a flag in a status register, not an interrupt flag. There is
> a corresponding interrupt flag, but that is cleared along with the rest,
> at the top of m_can_isr.

I agree, sorry for not being specific, the problem is cpu can not get into
m_can_isr for a long time in my case.

>
> I think you are losing messages because the traffic is too heavy for
> your system to read out the messages fast enough. That is the usual
> reason for seeing "Rx FIFO 0 Message Lost".

Seeing "Rx FIFO 0 Message Lost" is not my biggest problem. The problem is
my system is not responsive along this messages.

I changed m_can_do_rx_poll:

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
                 if (rxfs & RXFS_RFL) {
                         netdev_warn(dev, "Rx FIFO 0 Message Lost\n");
                         m_can_write(cdev, M_CAN_IR, IR_RF0L);
                 }

                 m_can_read_fifo(dev, rxfs);

                 quota--;
                 pkts++;
                 rxfs = m_can_read(cdev, M_CAN_RXF0S);
         }

         if (pkts)
                 can_led_event(dev, CAN_LED_EVENT_RX);

         return pkts;
}

And now my system is responsive - i sometimes get "Rx FIFO 0 Message Lost"
but one at a time - not 100k and this is not a big problem for me.
CAN works OK
So IMO it is a bug.

>
> --
> Regards,
>
> Torin Cooper-Bennun
> Software Engineer  | maxiluxsystems.com
>
Regards,

Mariusz

