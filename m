Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A386D1FA7
	for <lists+linux-can@lfdr.de>; Fri, 31 Mar 2023 14:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjCaMGu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 31 Mar 2023 08:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjCaMGt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 31 Mar 2023 08:06:49 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8351C1F3
        for <linux-can@vger.kernel.org>; Fri, 31 Mar 2023 05:06:47 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so23117086pjt.5
        for <linux-can@vger.kernel.org>; Fri, 31 Mar 2023 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680264407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QeqQz+yH+3+n83AEBUPaeyNlKgkILMLp2iF+d4/1vKE=;
        b=fGOoH+Uz1m6Pr+paV1qMOYKNv7q7TijTLUT9FinaHGmIw64XCvTHbpHDwgoCiZjXwe
         KmHsb30o+35PdsmcmCXsSSwekF+RVqc88SSN2c/3+138H2HnREwaRGcpLwp+QQ2dX8nH
         R4wu/ycDKI3PD30n4butkE1x7Fh9wsw1WJFFd8w3jOfUuBI+7nbXyoeumendmTyb3Mab
         9ecWW0nHYkezAbMbiHclQt7z7HjoZtxNZetAV0iSPPk44+IndW8BUtcepn78jmKNUbJG
         1fcsDGH3VAW1DZ2/1BZ1HE1pVXVV990ZqX0NFJoknkhR9ttlM/k9Tu6u+gbiikZsWsws
         LZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680264407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeqQz+yH+3+n83AEBUPaeyNlKgkILMLp2iF+d4/1vKE=;
        b=P+5uy0GJelskwxBRhaWjnRttNfXDhxl+6Mo2YqTwZav2Fq7BJPF5JWFo9UwTQ5SCQv
         p5xSoxwaUkv8BSLV/361RCRG6O5u/C7qjr8tulYh0xmSPZ+2AlUjSZUMOR23EI4qiwgI
         6GnzqE9vyr9P2+IriiyPZPWvi6iw4hABfieA153KnVDDLG7SmSBLHqs91jSqqBtsZ7df
         fKW7Hd6H0e0HBDtbXQuly8Hp32AoKYpCJm0ohEZmpgI+wb1F3SP8o1TXlArxkPthWZD9
         DntIzjDNBsVQlGKoRnMVXTFfUxawD9GFLQGR1OwXt21im/59sP3Bdb1ZgfutLzS0nW4d
         M6cg==
X-Gm-Message-State: AAQBX9ciWSlQZf67+vcMAzDO4C2IAig8lsOI/5+Cz3YNsBIk09Co+3He
        I0R06COukLDBJmB6zXQoNnk=
X-Google-Smtp-Source: AKy350amTVkSet+RJ2l4kmizb/KoMXWiC2xCf0CGh6K/X4EMLoAtk0PyHUy1Dg12t8riDzWLf2+5Uw==
X-Received: by 2002:a17:902:e749:b0:1a2:19c1:a952 with SMTP id p9-20020a170902e74900b001a219c1a952mr33409002plf.61.1680264406807;
        Fri, 31 Mar 2023 05:06:46 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902ee4400b001a240f053aasm1410709plo.180.2023.03.31.05.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 05:06:46 -0700 (PDT)
Date:   Fri, 31 Mar 2023 21:06:42 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, Hillf Danton <hdanton@sina.com>
Subject: Re: [RFC PATCH] can: isotp: fix race between isotp_sendsmg() and
 isotp_release()
Message-ID: <ZCbM0mTZFgfyWndH@dragonet>
References: <20230331102114.15164-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331102114.15164-1-socketcan@hartkopp.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Mar 31, 2023 at 12:21:14PM +0200, Oliver Hartkopp wrote:
> As discussed with Dae R. Jeong and Hillf Danton here [1] the sendmsg()
> function in isotp.c might get into a race condition when restoring the
> former tx.state from the old_state. This patch removes the old_state
> concept and implements a proper locking for ISOTP_IDLE transitions in
> isotp_sendmsg() inspired by a simplification idea from Hillf Danton.
> Additionally a new tx.state ISOTP_SHUTDOWN has been introduced to use
> the same locking mechanism from isotp_release() which resolves a
> potential race between isotp_sendsmg() and isotp_release().
> 
> [1] https://lore.kernel.org/linux-can/ZB%2F93xJxq%2FBUqAgG@dragonet/
> 
> Cc: Dae R. Jeong <threeearcat@gmail.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  net/can/isotp.c | 49 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 9bc344851704..2ba043f5a9cb 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -117,11 +117,12 @@ MODULE_ALIAS("can-proto-6");
>  enum {
>  	ISOTP_IDLE = 0,
>  	ISOTP_WAIT_FIRST_FC,
>  	ISOTP_WAIT_FC,
>  	ISOTP_WAIT_DATA,
> -	ISOTP_SENDING
> +	ISOTP_SENDING,
> +	ISOTP_SHUTDOWN,
>  };
>  
>  struct tpcon {
>  	unsigned int idx;
>  	unsigned int len;
> @@ -878,12 +879,12 @@ static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
>  {
>  	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
>  					     txtimer);
>  	struct sock *sk = &so->sk;
>  
> -	/* don't handle timeouts in IDLE state */
> -	if (so->tx.state == ISOTP_IDLE)
> +	/* don't handle timeouts in IDLE or SHUTDOWN state */
> +	if (so->tx.state == ISOTP_IDLE || so->tx.state == ISOTP_SHUTDOWN)
>  		return HRTIMER_NORESTART;
>  
>  	/* we did not get any flow control or echo frame in time */
>  
>  	/* report 'communication error on send' */
> @@ -916,37 +917,37 @@ static enum hrtimer_restart isotp_txfr_timer_handler(struct hrtimer *hrtimer)
>  
>  static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  {
>  	struct sock *sk = sock->sk;
>  	struct isotp_sock *so = isotp_sk(sk);
> -	u32 old_state = so->tx.state;
>  	struct sk_buff *skb;
>  	struct net_device *dev;
>  	struct canfd_frame *cf;
>  	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
>  	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
>  	s64 hrtimer_sec = ISOTP_ECHO_TIMEOUT;
>  	int off;
>  	int err;
>  
> -	if (!so->bound)
> +	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
>  		return -EADDRNOTAVAIL;
>  
> +wait_free_buffer:
>  	/* we do not support multiple buffers - for now */
> -	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE ||
> -	    wq_has_sleeper(&so->wait)) {
> -		if (msg->msg_flags & MSG_DONTWAIT) {
> -			err = -EAGAIN;
> -			goto err_out;
> -		}
> +	if (wq_has_sleeper(&so->wait) && (msg->msg_flags & MSG_DONTWAIT))
> +		return -EAGAIN;
>  
> -		/* wait for complete transmission of current pdu */
> -		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
> -		if (err)
> -			goto err_out;
> +	/* wait for complete transmission of current pdu */
> +	err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
> +	if (err)
> +		return err;
>  
> -		so->tx.state = ISOTP_SENDING;
> +	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
> +		if (so->tx.state == ISOTP_SHUTDOWN)
> +			return -EADDRNOTAVAIL;
> +
> +		goto wait_free_buffer;
>  	}
>  
>  	if (!size || size > MAX_MSG_LENGTH) {
>  		err = -EINVAL;
>  		goto err_out_drop;
> @@ -1072,25 +1073,24 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  		goto err_out_drop;
>  	}
>  
>  	if (wait_tx_done) {
>  		/* wait for complete transmission of current pdu */
> -		wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
> +		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
> +		if (err)
> +			return err;
>  
>  		if (sk->sk_err)
>  			return -sk->sk_err;
>  	}
>  
>  	return size;
>  
>  err_out_drop:
>  	/* drop this PDU and unlock a potential wait queue */
> -	old_state = ISOTP_IDLE;
> -err_out:
> -	so->tx.state = old_state;
> -	if (so->tx.state == ISOTP_IDLE)
> -		wake_up_interruptible(&so->wait);
> +	so->tx.state = ISOTP_IDLE;
> +	wake_up_interruptible(&so->wait);
>  
>  	return err;
>  }
>  
>  static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
> @@ -1147,15 +1147,18 @@ static int isotp_release(struct socket *sock)
>  		return 0;
>  
>  	so = isotp_sk(sk);
>  	net = sock_net(sk);
>  
> +wait_transmission_finish:
>  	/* wait for complete transmission of current pdu */
>  	wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
>  
> +	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SHUTDOWN) != ISOTP_IDLE)
> +		goto wait_transmission_finish;
> +
>  	/* force state machines to be idle also when a signal occurred */
> -	so->tx.state = ISOTP_IDLE;
>  	so->rx.state = ISOTP_IDLE;
>  
>  	spin_lock(&isotp_notifier_lock);
>  	while (isotp_busy_notifier == so) {
>  		spin_unlock(&isotp_notifier_lock);
> -- 
> 2.30.2
> 

All looks good for me. I tried to figure out abnormal thread
interleavings regarding the changes in sendmsg() and release(), but I
couldn't.

Thank you for your hard work!

Best regards,
Dae R. Jeong
