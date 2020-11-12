Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1252B013A
	for <lists+linux-can@lfdr.de>; Thu, 12 Nov 2020 09:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgKLIby (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Nov 2020 03:31:54 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:56295 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgKLIby (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Nov 2020 03:31:54 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 3DCD3FF809
        for <linux-can@vger.kernel.org>; Thu, 12 Nov 2020 08:31:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.903
X-Spam-Level: 
X-Spam-Status: No, score=-1.903 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.001, NO_RECEIVED=-0.001,
        NO_RELAYS=-0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pG5Udv0UlCxK for <linux-can@vger.kernel.org>;
        Thu, 12 Nov 2020 09:31:32 +0100 (CET)
Subject: Re: [PATCH 12/17] can: ems_usb: In ems_usb_start_xmit send only bytes
 with valid content to interface and not the complete buffer. Set first four
 bytes of buffer to 0. Wrapped long lines.
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     wg@grandegger.com
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
 <20201106170206.32162-13-uttenthaler@ems-wuensche.com>
 <c48ea36f-db08-6e3f-1e8d-80fd2238a7bd@pengutronix.de>
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Message-ID: <c45ff891-9899-c04c-0116-581f90ee271d@ems-wuensche.com>
Date:   Thu, 12 Nov 2020 09:31:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <c48ea36f-db08-6e3f-1e8d-80fd2238a7bd@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 06.11.20 um 18:58 schrieb Marc Kleine-Budde:
> On 11/6/20 6:02 PM, Gerhard Uttenthaler wrote:
>> Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
>> ---
>>  drivers/net/can/usb/ems_usb.c | 31 +++++++++++++++++++++++--------
>>  1 file changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
>> index b51a5eb65946..c464d644c833 100644
>> --- a/drivers/net/can/usb/ems_usb.c
>> +++ b/drivers/net/can/usb/ems_usb.c
>> @@ -902,25 +902,37 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
>>  	struct can_frame *cf = (struct can_frame *)skb->data;
>>  	struct ems_cpc_msg *msg;
>>  	struct urb *urb;
>> -	u8 *buf;
>>  	int i, err;
>> -	size_t size = CPC_HEADER_SIZE + CPC_MSG_HEADER_LEN
>> -			+ sizeof(struct cpc_can_msg);
>> +
>> +	u8 *buf;
>> +	size_t buf_size;
>> +	size_t buf_len = CPC_HEADER_SIZE + CPC_MSG_HEADER_LEN;
>>  
>>  	if (can_dropped_invalid_skb(netdev, skb))
>>  		return NETDEV_TX_OK;
>>  
>> -	/* create a URB, and a buffer for it, and copy the data to the URB */
>> +	buf_size = CPC_HEADER_SIZE +
>> +		   CPC_MSG_HEADER_LEN +
>> +		   sizeof(struct cpc_can_msg);
> 
> does it make sense to only allocate the length of the buffer needed to hold the
> data?I have considered that, but actual length depends on DLC, however not
when the frame is an RTR and this is different for Classic and FD. I
think code will get more complicated with the benefit only to save a few
bytes.

-- 
Gerhard

-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
