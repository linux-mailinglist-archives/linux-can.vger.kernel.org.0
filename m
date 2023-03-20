Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958356C2364
	for <lists+linux-can@lfdr.de>; Mon, 20 Mar 2023 22:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCTVIB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 20 Mar 2023 17:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCTVIB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Mar 2023 17:08:01 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208351632A
        for <linux-can@vger.kernel.org>; Mon, 20 Mar 2023 14:07:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679346477; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fT4dVDy6Kb6nAoxkXbNMsyU0fRyU1WtVkuot8GsjiYvdItviYIxhHDiyj2vUqxLSPC
    IAGzS0x5klmNtuuqXlAMn/irGO3Y4b5mhkIkxjcQY+rImjVyAMWgJPmfFfFYg06YYw2j
    xhNCpOojfGbs7JbNWdzP51EFFpnBWAsOOm/I7nZ+61xdP6hYEvt0n2dVHuNcswUCqJr1
    +wdA8gpALW+l/dFL+tUbPsXkNto4pexxrHPigjaiMYGP2O5pcHQJL45f7bsWYCDq7qUs
    UfTdw+EJZJ2qqoRNbqgzajOAUytYhVds2w4U8ORhCZEo31TpX/SpjZfATESc8J8skt17
    EY2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1679346477;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fXsQ/Na07+RaXOQd69gjdBR8EGcI1HtIjk4hRn8cMpE=;
    b=Km0hCVuovNz7JQNyiCrQZpUn7o+VitRPJCfFrScWexDFYQHNYi3WoitQdKr8O9I46N
    KJcdFIZQM4huC2vGt4FHemkM/D/hH+ggv6C/BjUyeLss24Dss7UqueLNNn9TS1pyEVUy
    7UWqjUSvuGsHKv4swXxUxchTmaeXhw7/3nRn/R5FU1KBjSUgiu58Pg5wg/jFg+EgbB7x
    OMzK3PllUaV5fZgUfpGC0F6hNjzX0qG8jlRHNOahTwhBSoaja3AopuM2X83WzDZj400b
    Sz54F0cjsu1aB+Lwm72lYcXvYwSgNbLj6tiiCyUlwftn0UuR9Xs6mV28cpsl+PASefXA
    WOeQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1679346477;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fXsQ/Na07+RaXOQd69gjdBR8EGcI1HtIjk4hRn8cMpE=;
    b=q7fkDkqu2lVZFZ99jb9wA8zYW6tsYQrJmi6ikF/QTP/CjkxDYS2kKIE/Sg9CVB+5od
    iBTj1HoTxCK4RiEnJNtSiZTR2yo7heTeUvfMsY20zJGt+fSlPMAbbBhjdEUlB02tVk/Y
    QmOuvYdKCOkPYwdOMiUGgbspeBPQVykQznj/BEgqhU6pu23kPMcXTfUaVUD0pcOQPLHv
    AwWFa1bVUhZilp6rnipoNimmmjLoOpAeRxNwnyTiu+y7uYa2QLkDGMSUCZFNko1YuDxt
    5YG9sxWfiqDIwHJjtMlcRUlr5KiQj3Z4s7l34MM8Y0ebhBZ4GF2y465l8t0ZgXuA/q3C
    3Dyw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id n9397fz2KL7uBoz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 20 Mar 2023 22:07:56 +0100 (CET)
Message-ID: <c5451b95-5732-b3ed-38f5-1b09e74c0541@hartkopp.net>
Date:   Mon, 20 Mar 2023 22:07:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v2] can: isotp: add module parameter for maximum pdu
 size
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20230313172510.3851-1-socketcan@hartkopp.net>
 <20230320162406.5mkbvcmyx7nyqvjc@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230320162406.5mkbvcmyx7nyqvjc@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 20.03.23 17:24, Marc Kleine-Budde wrote:
> On 13.03.2023 18:25:10, Oliver Hartkopp wrote:
>> With ISO 15765-2:2016 the PDU size is not limited to 2^12 - 1 (4095) bytes
>> but can be represented as a 32 bit unsigned integer value which allows
>> 2^32 - 1 bytes (~4GB). The use-cases like automotive unified diagnostic
>> services (UDS) and flashing of ECUs still use the small static buffers
>> which are provided at socket creation time.
>>
>> When a use-case requires to transfer PDUs up to 1025 kByte the maximum
>> PDU size can now be extended by setting the module parameter max_pdu_size.
>> The extended size buffers are only allocated on a per-socket/connection
>> base when needed at run-time.
>>
>> Link: https://github.com/raspberrypi/linux/issues/5371
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> See comments inline
> 
>> ---
>>
>> v2: limit the minimum 'max_pdu_size' to 4095 to maintain the classic behavior
>>      before ISO 15765-2:2016
>>
>> net/can/isotp.c | 65 ++++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 56 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 9bc344851704..8a5d278c8bf1 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -83,14 +83,25 @@ MODULE_ALIAS("can-proto-6");
>>   			 (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG) : \
>>   			 (CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG))
>>   
>>   /* ISO 15765-2:2016 supports more than 4095 byte per ISO PDU as the FF_DL can
>>    * take full 32 bit values (4 Gbyte). We would need some good concept to handle
>> - * this between user space and kernel space. For now increase the static buffer
>> - * to something about 64 kbyte to be able to test this new functionality.
>> + * this between user space and kernel space. For now set the static buffer to
>> + * something about 8 kbyte to be able to test this new functionality.
>>    */
>> -#define MAX_MSG_LENGTH 66000
>> +#define DEFAULT_MAX_PDU_SIZE 8300
>> +
>> +/* maximum PDU size before ISO 15765-2:2016 extension was 4095 */
>> +#define MAX_12BIT_PDU_SIZE 4095
>> +
>> +/* limit the isotp pdu size from the optional module parameter to 1MByte */
>> +#define MAX_PDU_SIZE (1025 * 1024U)
>> +
>> +static unsigned int max_pdu_size __read_mostly = DEFAULT_MAX_PDU_SIZE;
>> +module_param(max_pdu_size, uint, 0444);
>> +MODULE_PARM_DESC(max_pdu_size, "maximum isotp pdu size (default "
>> +		 __stringify(DEFAULT_MAX_PDU_SIZE) ")");
>>   
>>   /* N_PCI type values in bits 7-4 of N_PCI bytes */
>>   #define N_PCI_SF 0x00	/* single frame */
>>   #define N_PCI_FF 0x10	/* first frame */
>>   #define N_PCI_CF 0x20	/* consecutive frame */
>> @@ -121,17 +132,19 @@ enum {
>>   	ISOTP_WAIT_DATA,
>>   	ISOTP_SENDING
>>   };
>>   
>>   struct tpcon {
>> -	unsigned int idx;
>> +	u8 *buf;
>> +	unsigned int buflen;
>>   	unsigned int len;
>> +	unsigned int idx;
>>   	u32 state;
>>   	u8 bs;
>>   	u8 sn;
>>   	u8 ll_dl;
>> -	u8 buf[MAX_MSG_LENGTH + 1];
>> +	u8 sbuf[DEFAULT_MAX_PDU_SIZE];
>>   };
>>   
>>   struct isotp_sock {
>>   	struct sock sk;
>>   	int bound;
>> @@ -501,11 +514,21 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
>>   	off = (so->rx.ll_dl > CAN_MAX_DLEN) ? 1 : 0;
>>   
>>   	if (so->rx.len + ae + off + ff_pci_sz < so->rx.ll_dl)
>>   		return 1;
>>   
>> -	if (so->rx.len > MAX_MSG_LENGTH) {
>> +	/* PDU size > default => try max_pdu_size */
> 
> What exactly is "so->rx.len"?
> 

This is the PDU size that is sent to this local host.

>> +	if (so->rx.len > so->rx.buflen && so->rx.buflen < max_pdu_size) {
>                                            ^^^^^^^^^^^^^
> Why are you checking so->rx.buflen against max_pdu_size? Should you
> check rx.len instead?

if (to be received PDU does not fit into the rx-buffer AND the rx-buffer 
has not be extended to  max_pdu_size so far)
{
	Try to increase the rx-buffer to max_pdu_size
}

> 
>> +		u8 *newbuf = kmalloc(max_pdu_size, GFP_ATOMIC);
> 
> In what context is this code executed? Is it really atomic?

Yes. In NET_RX softirq.

> Why are you allocating the max_pdu_size, not rx.len?

There is one upper limit which is selected when the 8300 bytes (99,9% of 
isotp use-cases) are not enough.

I intentionally did not want to handle re-allocations for every increase 
of received PDU size on this socket.

Just for simplicity reasons.

> 
>> +
>> +		if (newbuf) {
>> +			so->rx.buf = newbuf;
>> +			so->rx.buflen = max_pdu_size;
>> +		}
>> +	}
>> +
>> +	if (so->rx.len > so->rx.buflen) {
> 
> This patch is also taken if the kmalloc() fails, right?

s/patch/path/ ?!

Yes. At the end even the extended buffer might be too small. And when we 
don't have enough space - either with our without kmalloc() - it throws 
and error.

For that reason a failed kmalloc() does not create any stress. We just 
stay on the default buffer.

> 
>>   		/* send FC frame with overflow status */
>>   		isotp_send_fc(sk, ae, ISOTP_FC_OVFLW);
>>   		return 1;
>>   	}
>>   
>> @@ -805,11 +828,11 @@ static void isotp_create_fframe(struct canfd_frame *cf, struct isotp_sock *so,
>>   	cf->len = so->tx.ll_dl;
>>   	if (ae)
>>   		cf->data[0] = so->opt.ext_address;
>>   
>>   	/* create N_PCI bytes with 12/32 bit FF_DL data length */
>> -	if (so->tx.len > 4095) {
>> +	if (so->tx.len > MAX_12BIT_PDU_SIZE) {
>>   		/* use 32 bit FF_DL notation */
>>   		cf->data[ae] = N_PCI_FF;
>>   		cf->data[ae + 1] = 0;
>>   		cf->data[ae + 2] = (u8)(so->tx.len >> 24) & 0xFFU;
>>   		cf->data[ae + 3] = (u8)(so->tx.len >> 16) & 0xFFU;
>> @@ -945,11 +968,21 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>   			goto err_out;
>>   
>>   		so->tx.state = ISOTP_SENDING;
>>   	}
>>   
>> -	if (!size || size > MAX_MSG_LENGTH) {
>> +	/* PDU size > default => try max_pdu_size */
>> +	if (size > so->tx.buflen && so->tx.buflen < max_pdu_size) {
>> +		u8 *newbuf = kmalloc(max_pdu_size, GFP_KERNEL);
> 
> Same questions as in the RX-path. BTW: for the TX-path you can implement
> something like in the j1939 protocol. There we don't allocate the full
> TX buffer anymore, but handle it in chunks. Talk to Oleksij for details.

As explained above the reason for this buffer extension is a rare 
use-case that two people have been asking for in nine years.

I've been thinking about some sendfile() implementation too. But this 
again would bloat the code and would not solve the rx side.

Therefore this KISS approach seemed the right decision to me to provide 
such a feature for people who know what they are doing and who only 
tweak the module parameter on demand.

> 
>> +
>> +		if (newbuf) {
>> +			so->tx.buf = newbuf;
>> +			so->tx.buflen = max_pdu_size;
>> +		}
>> +	}
>> +
>> +	if (!size || size > so->tx.buflen) {
>>   		err = -EINVAL;
>>   		goto err_out_drop;
>>   	}
>>   
>>   	/* take care of a potential SF_DL ESC offset for TX_DL > 8 */
>> @@ -1193,10 +1226,16 @@ static int isotp_release(struct socket *sock)
>>   	hrtimer_cancel(&so->rxtimer);
>>   
>>   	so->ifindex = 0;
>>   	so->bound = 0;
>>   
>> +	if (so->rx.buf != so->rx.sbuf)
>> +		kfree(so->rx.buf);
>> +
>> +	if (so->tx.buf != so->tx.sbuf)
>> +		kfree(so->tx.buf);
>> +
>>   	sock_orphan(sk);
>>   	sock->sk = NULL;
>>   
>>   	release_sock(sk);
>>   	sock_put(sk);
>> @@ -1589,10 +1628,15 @@ static int isotp_init(struct sock *sk)
>>   	so->tx.ll_dl = so->ll.tx_dl;
>>   
>>   	so->rx.state = ISOTP_IDLE;
>>   	so->tx.state = ISOTP_IDLE;
>>   
>> +	so->rx.buf = so->rx.sbuf;
>> +	so->tx.buf = so->tx.sbuf;
>> +	so->rx.buflen = DEFAULT_MAX_PDU_SIZE;
> 
> what about: ARRAY_SIZE(so->rx.sbuf)
> 

Looks good. I was just unsure which macro to use ;-)

>> +	so->tx.buflen = DEFAULT_MAX_PDU_SIZE;
>> +

here too. This would use the DEFAULT_MAX_PDU_SIZE at one single point. 
No chance to get these values out of sync.

Best regards,
Oliver

>>   	hrtimer_init(&so->rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
>>   	so->rxtimer.function = isotp_rx_timer_handler;
>>   	hrtimer_init(&so->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
>>   	so->txtimer.function = isotp_tx_timer_handler;
>>   	hrtimer_init(&so->txfrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
>> @@ -1656,11 +1700,14 @@ static struct notifier_block canisotp_notifier = {
>>   
>>   static __init int isotp_module_init(void)
>>   {
>>   	int err;
>>   
>> -	pr_info("can: isotp protocol\n");
>> +	max_pdu_size = max_t(unsigned int, max_pdu_size, MAX_12BIT_PDU_SIZE);
>> +	max_pdu_size = min_t(unsigned int, max_pdu_size, MAX_PDU_SIZE);
>> +
>> +	pr_info("can: isotp protocol (max_pdu_size %d)\n", max_pdu_size);
>>   
>>   	err = can_proto_register(&isotp_can_proto);
>>   	if (err < 0)
>>   		pr_err("can: registration of isotp protocol failed %pe\n", ERR_PTR(err));
>>   	else
>> -- 
>> 2.30.2
>>
>>
> 
> Marc
> 
