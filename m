Return-Path: <linux-can+bounces-6377-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBkYEWuAemmc7AEAu9opvQ
	(envelope-from <linux-can+bounces-6377-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 22:32:27 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7D2A9211
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 22:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF83630071D2
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 21:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7596B3164C8;
	Wed, 28 Jan 2026 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="AgWkUuUV";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DtYD04rw"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4AC305057;
	Wed, 28 Jan 2026 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635941; cv=pass; b=lHUQ+H/HfdarMcYuPUtCYjrWvMAJHLxs2W6JoVRdAx1SMTV8pTJkWO4oAfz3Ap7o7AWPJppywiVs6bNnACP8/CzHaysKYAKA4WuuNF+dhYqT6pBYOyLUbEV9wqf4qw/ILPXuuRxHc/71Q27iBG8OWtVf4T/COEB5UX2X6n3tc20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635941; c=relaxed/simple;
	bh=ldSzGkfPFiTWmTrAFXdao94w2xiRa3owRNmxRS4Bnyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VNEvGp/20YJ/oUaQ/i77l4foPuEagpScuvWuyX3R4XI7apZEO2oHO7G5vZGxECe9e77dr5Wo6fwUtEpNRGo7kq2hCG+LIxx8JZfsH63vdLVvYPixe6FCeBEQwUi9rt3jLEYUqO+YNIiE+qqqTHoqZ/HBt/2USmFUzraNb+z2mW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=AgWkUuUV; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DtYD04rw; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769635567; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tJEqUuwHK1uNHSdxXnpYB8prR0NiXQJuye20J7BrMNBj1jtb+CGWmkDK5Q1OvvHnKj
    ACG/GEPPvhbkvCwXCW6diqyNZJDjQgQqpWdpRUUy56lhGZ37tnXPsJRFG1NINtsCIQn6
    YW5kPijpPor5Jl8J5JZeF1WdXvlH5KSqiMNXtaE6Wkk7R8XUkyy5xJIhZp7YAaC5uJpB
    KUdo8/4wC2CCR6jGiFTyBWFx73Pk1Dgfsuc4D03fXlNO6c4p+0Fkjt0SGGfI/DKU8l06
    eOfQR4q4A5Q5Z+HKDWqzK5ms325vP6dIVVaiX70n+Ix5z2R24pv6+GLAIlpYu9DcDOex
    Hs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769635567;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=dmT1fyYrLZfB0RWP+3agglPBSclcvK8HO/trD/n/X0E=;
    b=pMDKhOUknhmqm/yCTd/p3GgiaXFoc2aXKc0Py+SYn5pb+/FyrnEk7z/IWhv7vlSw3S
    XtHZiZIbA2K67gzZ6fwQ8xjDy6cDgneKpUMzXZ7FvnayAYMHa3VJUpzT2oXTBRxGwvX1
    XrweDNCaxryifOASYIsyCKkfbFKXh8VKdR7RGz8fyJKm+NVPYL8wg6D2/ozX0apN4UeW
    ITRUndM/92cd0MVRDhKWWYp/IYTS8HwgxxozsCPqkTVnDJPXI5qpZrYExbg+Nhl1P59F
    dj0ZsIcNtxEIgORvksW0kclRWim41ewGunu0PuL8jeKy4bJxNxaJyiqjU6WqORjrM2u1
    i+jg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769635567;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=dmT1fyYrLZfB0RWP+3agglPBSclcvK8HO/trD/n/X0E=;
    b=AgWkUuUVhK3O0EozXAr8fafka8CmUCDC8eSKU/jiHZvKUjKcZGOZJhFx+gry3gChjB
    kFPBiXTLjRBP7huxOhrpuM/gOs6GOWHNBL7PmZBMNzrAwUuEIUvmnnXNwX+mzUGDD5ox
    ZI8D2bu4zt+oMNCrrC7/aCi5Mu7ZOb3qpFEh94rkgz+26HCPc6WStbdI67O+PCNH1p5+
    1aPfjPSimMC2jdH0GSZwuF0dpAtQcJvthYAA3CTMRf+ZqGON6ur/bbGtYhes3AbJ6vCW
    ricKxjdHdjthnZlAIUzZZ2MZaqPQGuug61wQVyNHSgk0GxdcGA40d7ZgcB82hq64Jq2f
    GOdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769635567;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=dmT1fyYrLZfB0RWP+3agglPBSclcvK8HO/trD/n/X0E=;
    b=DtYD04rw4WBGo/eQQEQ3a8FsGfPXMdP5GoS0S/GRkDjXriYGhQ63/jPHVxQWECWand
    AAE3Wb/XIJJ4lQxsKrAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8YjX10Q=="
Received: from [IPV6:2a00:6020:4a38:6810::76e]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20SLQ7p6x
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 28 Jan 2026 22:26:07 +0100 (CET)
Message-ID: <9cad2991-e99b-4bbe-99c8-ee3c9974ee74@hartkopp.net>
Date: Wed, 28 Jan 2026 22:26:02 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 2/7] can: use netdev_put() instead of
 deprecated dev_put()
To: netdev@vger.kernel.org, linux-can@vger.kernel.org
References: <20260128-can_skb_ext-v1-0-71b8bcbfd8cf@hartkopp.net>
 <20260128-can_skb_ext-v1-2-71b8bcbfd8cf@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260128-can_skb_ext-v1-2-71b8bcbfd8cf@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6377-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,hartkopp.net:dkim,hartkopp.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA7D2A9211
X-Rspamd-Action: no action



On 28.01.26 22:10, Oliver Hartkopp via B4 Relay wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Checkpatch complained about using dev_put() in the following patch of this
> series. Prepare the CAN subsystem to use netdev_put() consistently.

Sorry. This does not compile.

I looked at a code where dev_put() was just replaced by netdev_put().

But recently a netdevice tracker has been added :-/

Will send a V4 version where also hopefully I get the "b4 prep 
--auto-to-cc" working ...

Best regards,
Oliver

> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   net/can/bcm.c          | 18 +++++++++---------
>   net/can/isotp.c        | 18 +++++++++---------
>   net/can/j1939/main.c   |  6 +++---
>   net/can/j1939/socket.c |  8 ++++----
>   net/can/raw.c          |  6 +++---
>   5 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 8ed60f18c2eaff7053cb2c76e5e4cf1124dd3ac5..f76d60252803e62f438fd1936f366008698172e7 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -339,11 +339,11 @@ static void bcm_can_tx(struct bcm_op *op)
>   	if (op->count > 0)
>   		op->count--;
>   
>   	spin_unlock_bh(&op->bcm_tx_lock);
>   out:
> -	dev_put(dev);
> +	netdev_put(dev);
>   }
>   
>   /*
>    * bcm_send_to_user - send a BCM message to the userspace
>    *                    (consisting of bcm_msg_head + x CAN frames)
> @@ -852,11 +852,11 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
>   
>   					dev = dev_get_by_index(sock_net(op->sk),
>   							       op->ifindex);
>   					if (dev) {
>   						bcm_rx_unreg(dev, op);
> -						dev_put(dev);
> +						netdev_put(dev);
>   					}
>   				}
>   			} else
>   				can_rx_unregister(sock_net(op->sk), NULL,
>   						  op->can_id,
> @@ -1290,11 +1290,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   						      REGMASK(op->can_id),
>   						      bcm_rx_handler, op,
>   						      "bcm", sk);
>   
>   				op->rx_reg_dev = dev;
> -				dev_put(dev);
> +				netdev_put(dev);
>   			}
>   
>   		} else
>   			err = can_rx_register(sock_net(sk), NULL, op->can_id,
>   					      REGMASK(op->can_id),
> @@ -1344,11 +1344,11 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
>   
>   	can_skb_prv(skb)->ifindex = dev->ifindex;
>   	skb->dev = dev;
>   	can_skb_set_owner(skb, sk);
>   	err = can_send(skb, 1); /* send with loopback */
> -	dev_put(dev);
> +	netdev_put(dev);
>   
>   	if (err)
>   		return err;
>   
>   	return cfsiz + MHSIZ;
> @@ -1403,15 +1403,15 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   			dev = dev_get_by_index(sock_net(sk), ifindex);
>   			if (!dev)
>   				return -ENODEV;
>   
>   			if (dev->type != ARPHRD_CAN) {
> -				dev_put(dev);
> +				netdev_put(dev);
>   				return -ENODEV;
>   			}
>   
> -			dev_put(dev);
> +			netdev_put(dev);
>   		}
>   	}
>   
>   	lock_sock(sk);
>   
> @@ -1622,11 +1622,11 @@ static int bcm_release(struct socket *sock)
>   				struct net_device *dev;
>   
>   				dev = dev_get_by_index(net, op->ifindex);
>   				if (dev) {
>   					bcm_rx_unreg(dev, op);
> -					dev_put(dev);
> +					netdev_put(dev);
>   				}
>   			}
>   		} else
>   			can_rx_unregister(net, NULL, op->can_id,
>   					  REGMASK(op->can_id),
> @@ -1682,17 +1682,17 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
>   		if (!dev) {
>   			ret = -ENODEV;
>   			goto fail;
>   		}
>   		if (dev->type != ARPHRD_CAN) {
> -			dev_put(dev);
> +			netdev_put(dev);
>   			ret = -ENODEV;
>   			goto fail;
>   		}
>   
>   		bo->ifindex = dev->ifindex;
> -		dev_put(dev);
> +		netdev_put(dev);
>   
>   	} else {
>   		/* no interface reference for ifindex = 0 ('any' CAN device) */
>   		bo->ifindex = 0;
>   	}
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 4bb60b8f9b96188a328e77be2fdefcb879da1089..b36173db119c85a6ef74a172236c08b372b875a9 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -258,11 +258,11 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
>   	can_send_ret = can_send(nskb, 1);
>   	if (can_send_ret)
>   		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
>   			       __func__, ERR_PTR(can_send_ret));
>   
> -	dev_put(dev);
> +	netdev_put(dev);
>   
>   	/* reset blocksize counter */
>   	so->rx.bs = 0;
>   
>   	/* reset last CF frame rx timestamp for rx stmin enforcement */
> @@ -771,11 +771,11 @@ static void isotp_send_cframe(struct isotp_sock *so)
>   	if (!dev)
>   		return;
>   
>   	skb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv), GFP_ATOMIC);
>   	if (!skb) {
> -		dev_put(dev);
> +		netdev_put(dev);
>   		return;
>   	}
>   
>   	can_skb_reserve(skb);
>   	can_skb_prv(skb)->ifindex = dev->ifindex;
> @@ -809,11 +809,11 @@ static void isotp_send_cframe(struct isotp_sock *so)
>   		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
>   			       __func__, ERR_PTR(can_send_ret));
>   		if (can_send_ret == -ENOBUFS)
>   			pr_notice_once("can-isotp: tx queue is full\n");
>   	}
> -	dev_put(dev);
> +	netdev_put(dev);
>   }
>   
>   static void isotp_create_fframe(struct canfd_frame *cf, struct isotp_sock *so,
>   				int ae)
>   {
> @@ -999,11 +999,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   	}
>   
>   	skb = sock_alloc_send_skb(sk, so->ll.mtu + sizeof(struct can_skb_priv),
>   				  msg->msg_flags & MSG_DONTWAIT, &err);
>   	if (!skb) {
> -		dev_put(dev);
> +		netdev_put(dev);
>   		goto err_out_drop;
>   	}
>   
>   	can_skb_reserve(skb);
>   	can_skb_prv(skb)->ifindex = dev->ifindex;
> @@ -1081,11 +1081,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   	cf->flags = so->ll.tx_flags;
>   
>   	skb->dev = dev;
>   	skb->sk = sk;
>   	err = can_send(skb, 1);
> -	dev_put(dev);
> +	netdev_put(dev);
>   	if (err) {
>   		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
>   			       __func__, ERR_PTR(err));
>   
>   		/* no transmission -> no timeout monitoring */
> @@ -1212,11 +1212,11 @@ static int isotp_release(struct socket *sock)
>   							  isotp_rcv, sk);
>   
>   				can_rx_unregister(net, dev, so->txid,
>   						  SINGLE_MASK(so->txid),
>   						  isotp_rcv_echo, sk);
> -				dev_put(dev);
> +				netdev_put(dev);
>   				synchronize_rcu();
>   			}
>   		}
>   	}
>   
> @@ -1304,16 +1304,16 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>   	if (!dev) {
>   		err = -ENODEV;
>   		goto out;
>   	}
>   	if (dev->type != ARPHRD_CAN) {
> -		dev_put(dev);
> +		netdev_put(dev);
>   		err = -ENODEV;
>   		goto out;
>   	}
>   	if (READ_ONCE(dev->mtu) < so->ll.mtu) {
> -		dev_put(dev);
> +		netdev_put(dev);
>   		err = -EINVAL;
>   		goto out;
>   	}
>   	if (!(dev->flags & IFF_UP))
>   		notify_enetdown = 1;
> @@ -1329,11 +1329,11 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>   
>   	/* register for echo skb's */
>   	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
>   			isotp_rcv_echo, sk, "isotpe", sk);
>   
> -	dev_put(dev);
> +	netdev_put(dev);
>   
>   	/* switch to new settings */
>   	so->ifindex = ifindex;
>   	so->rxid = rx_id;
>   	so->txid = tx_id;
> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index a93af55df5fd500fa5d564160ad563a3883d2eac..dadf5be529070dcb4c077e68049e091511ef5361 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -161,11 +161,11 @@ static void __j1939_priv_release(struct kref *kref)
>   
>   	WARN_ON_ONCE(!list_empty(&priv->active_session_list));
>   	WARN_ON_ONCE(!list_empty(&priv->ecus));
>   	WARN_ON_ONCE(!list_empty(&priv->j1939_socks));
>   
> -	dev_put(ndev);
> +	netdev_put(ndev);
>   	kfree(priv);
>   }
>   
>   void j1939_priv_put(struct j1939_priv *priv)
>   {
> @@ -279,11 +279,11 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
>   		/* Someone was faster than us, use their priv and roll
>   		 * back our's.
>   		 */
>   		kref_get(&priv_new->rx_kref);
>   		mutex_unlock(&j1939_netdev_lock);
> -		dev_put(ndev);
> +		netdev_put(ndev);
>   		kfree(priv);
>   		return priv_new;
>   	}
>   	j1939_priv_set(ndev, priv);
>   
> @@ -296,11 +296,11 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
>   
>    out_priv_put:
>   	j1939_priv_set(ndev, NULL);
>   	mutex_unlock(&j1939_netdev_lock);
>   
> -	dev_put(ndev);
> +	netdev_put(ndev);
>   	kfree(priv);
>   
>   	return ERR_PTR(ret);
>   }
>   
> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 1589e8ca634ecc2b59eb0c2a1e48f546fafccbe0..ad188a86790f269b8a9d022e67d0ef3ea8560349 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -481,30 +481,30 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
>   			ret = -ENODEV;
>   			goto out_release_sock;
>   		}
>   
>   		if (ndev->reg_state != NETREG_REGISTERED) {
> -			dev_put(ndev);
> +			netdev_put(ndev);
>   			ret = -ENODEV;
>   			goto out_release_sock;
>   		}
>   
>   		can_ml = can_get_ml_priv(ndev);
>   		if (!can_ml) {
> -			dev_put(ndev);
> +			netdev_put(ndev);
>   			ret = -ENODEV;
>   			goto out_release_sock;
>   		}
>   
>   		if (!(ndev->flags & IFF_UP)) {
> -			dev_put(ndev);
> +			netdev_put(ndev);
>   			ret = -ENETDOWN;
>   			goto out_release_sock;
>   		}
>   
>   		priv = j1939_netdev_start(ndev);
> -		dev_put(ndev);
> +		netdev_put(ndev);
>   		if (IS_ERR(priv)) {
>   			ret = PTR_ERR(priv);
>   			goto out_release_sock;
>   		}
>   
> diff --git a/net/can/raw.c b/net/can/raw.c
> index fb4f9c854df04d90ed6bd4601c616ac39bb85ad9..cf217671d9ce9419c5e32f926bf64df5f95e4a1f 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -518,11 +518,11 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
>   			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
>   	}
>   
>   out_put_dev:
>   	/* remove potential reference from dev_get_by_index() */
> -	dev_put(dev);
> +	netdev_put(dev);
>   out:
>   	release_sock(sk);
>   	rtnl_unlock();
>   
>   	if (notify_enetdown) {
> @@ -989,21 +989,21 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   
>   	skb_setup_tx_timestamp(skb, &sockc);
>   
>   	err = can_send(skb, ro->loopback);
>   
> -	dev_put(dev);
> +	netdev_put(dev);
>   
>   	if (err)
>   		goto send_failed;
>   
>   	return size;
>   
>   free_skb:
>   	kfree_skb(skb);
>   put_dev:
> -	dev_put(dev);
> +	netdev_put(dev);
>   send_failed:
>   	return err;
>   }
>   
>   static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
> 


