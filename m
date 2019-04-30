Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFF0F44F
	for <lists+linux-can@lfdr.de>; Tue, 30 Apr 2019 12:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfD3Kg6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 Apr 2019 06:36:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56785 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfD3Kg5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 30 Apr 2019 06:36:57 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1hLQ85-0002oh-FX; Tue, 30 Apr 2019 12:36:53 +0200
Subject: Re: [PATCH v2 1/2] j1939: add MSG_ERRQUEUE support
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     kernel@pengutronix.de, linux-can@vger.kernel.org,
        robin@protonic.nl, david@protonic.nl
References: <20190427045516.27063-1-o.rempel@pengutronix.de>
 <20190427045516.27063-2-o.rempel@pengutronix.de>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <27caf8f0-c99c-9ced-7249-a2cf1eb8c1e1@pengutronix.de>
Date:   Tue, 30 Apr 2019 12:36:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190427045516.27063-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

We spotted an issue in current design. Packet information will be lost if socket was 
configured with SOF_TIMESTAMPING_OPT_TSONLY..

On 27.04.19 06:55, Oleksij Rempel wrote:
> Add two optional types of TX status notifications:
> 1. Generic notifications enabled with SO_J1939_RECVERR.
>     This will send status only on end of (E)TP transfer.
> 2. Verbose TX status notifications enabled with SO_J1939_RECV_TX_STATUS.
>     This will send additional TX status for each TP sized transferred and
>     confirmed block. This type of notifications can be enabled only if
>     SO_J1939_RECVERR is enabled as well.
> 
> The notifications are done over socket error queue. Each packet contains
> j1939_pktinfo in the payload and error value in the SKB_EXT_ERR.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   include/uapi/linux/can/j1939.h |  10 +++
>   net/can/j1939/j1939-priv.h     |   5 ++
>   net/can/j1939/socket.c         | 115 +++++++++++++++++++++++++++++++--
>   net/can/j1939/transport.c      |  11 +++-
>   4 files changed, 134 insertions(+), 7 deletions(-)
> 
> diff --git a/include/uapi/linux/can/j1939.h b/include/uapi/linux/can/j1939.h
> index c7eb94d2ab10..9f896401fa79 100644
> --- a/include/uapi/linux/can/j1939.h
> +++ b/include/uapi/linux/can/j1939.h
> @@ -66,12 +66,16 @@ enum {
>   	SO_J1939_PROMISC = 2,	/* set/clr promiscuous mode */
>   	SO_J1939_RECV_OWN = 3,
>   	SO_J1939_SEND_PRIO = 4,
> +	SO_J1939_RECVERR = 5,
> +	SO_J1939_RECV_TX_STATUS = 6,
>   };
>   
>   enum {
>   	SCM_J1939_DEST_ADDR = 1,
>   	SCM_J1939_DEST_NAME = 2,
>   	SCM_J1939_PRIO = 3,
> +	SCM_J1939_RECVERR = 4,
> +	SCM_J1939_PKTINFO = 5,
>   };
>   
>   struct j1939_filter {
> @@ -83,6 +87,12 @@ struct j1939_filter {
>   	__u8 addr_mask;
>   };
>   
> +struct j1939_pktinfo {
> +	__u64 cookie;
> +	__u32 size;
> +	__u32 size_done;
> +};
> +
>   #define J1939_FILTER_MAX 512 /* maximum number of j1939_filter set via setsockopt() */
>   
>   #endif /* !_UAPI_CAN_J1939_H_ */
> diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
> index 4cb2e63a86c4..fac316c45045 100644
> --- a/net/can/j1939/j1939-priv.h
> +++ b/net/can/j1939/j1939-priv.h
> @@ -10,6 +10,7 @@
>   
>   /* TODO: return ENETRESET on busoff. */
>   
> +struct j1939_session;
>   /* j1939 devices */
>   struct j1939_ecu {
>   	struct list_head list;
> @@ -152,6 +153,8 @@ int j1939_send_one(struct j1939_priv *priv, struct sk_buff *skb);
>   void j1939_sk_recv(struct j1939_priv *priv, struct sk_buff *skb);
>   void j1939_sk_send_multi_abort(struct j1939_priv *priv, struct sock *sk,
>   			       int err);
> +void j1939_sk_err_queue(struct j1939_session *session);
> +void j1939_sk_err_queue_tx_status(struct j1939_session *session);
>   
>   /* stack entries */
>   struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
> @@ -207,6 +210,8 @@ struct j1939_session {
>   	bool transmission;
>   	bool extd;
>   	unsigned int total_message_size; /* Total message size, number of bytes */
> +	int err;
> +	u64 cookie;
>   
>   	/* Packets counters for a (extended) transfer session. The packet is
>   	 * maximal of 7 bytes. */
> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index ea9ce6d99332..5572fdc7b67c 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -9,6 +9,7 @@
>   
>   #include <linux/can/core.h>
>   #include <linux/can/skb.h>
> +#include <linux/errqueue.h>
>   #include <linux/if_arp.h>
>   
>   #include "j1939-priv.h"
> @@ -23,6 +24,8 @@ struct j1939_sock {
>   #define J1939_SOCK_CONNECTED BIT(1)
>   #define J1939_SOCK_PROMISC BIT(2)
>   #define J1939_SOCK_RECV_OWN BIT(3)
> +#define J1939_SOCK_RECVERR BIT(4)
> +#define J1939_SOCK_RECV_TX_STATUS BIT(6)
>   	int state;
>   
>   	int ifindex;
> @@ -487,7 +490,7 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
>   {
>   	struct sock *sk = sock->sk;
>   	struct j1939_sock *jsk = j1939_sk(sk);
> -	int tmp, count = 0;
> +	int tmp, count = 0, ret = 0;
>   	struct j1939_filter *filters = NULL, *ofilters;
>   
>   	if (level != SOL_CAN_J1939)
> @@ -531,6 +534,18 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
>   	case SO_J1939_RECV_OWN:
>   		return j1939_sk_setsockopt_flag(jsk, optval, optlen,
>   						J1939_SOCK_RECV_OWN);
> +	case SO_J1939_RECVERR:
> +		ret = j1939_sk_setsockopt_flag(jsk, optval, optlen,
> +						J1939_SOCK_RECVERR);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (!(jsk->state & J1939_SOCK_RECVERR))
> +			skb_queue_purge(&sk->sk_error_queue);
> +		return ret;
> +	case SO_J1939_RECV_TX_STATUS:
> +		return j1939_sk_setsockopt_flag(jsk, optval, optlen,
> +						J1939_SOCK_RECV_TX_STATUS);
>   	case SO_J1939_SEND_PRIO:
>   		if (optlen != sizeof(tmp))
>   			return -EINVAL;
> @@ -575,6 +590,12 @@ static int j1939_sk_getsockopt(struct socket *sock, int level, int optname,
>   	case SO_J1939_RECV_OWN:
>   		tmp = (jsk->state & J1939_SOCK_RECV_OWN) ? 1 : 0;
>   		break;
> +	case SO_J1939_RECVERR:
> +		tmp = (jsk->state & J1939_SOCK_RECVERR) ? 1 : 0;
> +		break;
> +	case SO_J1939_RECV_TX_STATUS:
> +		tmp = (jsk->state & J1939_SOCK_RECV_TX_STATUS) ? 1 : 0;
> +		break;
>   	case SO_J1939_SEND_PRIO:
>   		tmp = j1939_prio(jsk->sk.sk_priority);
>   		break;
> @@ -604,10 +625,15 @@ static int j1939_sk_recvmsg(struct socket *sock, struct msghdr *msg,
>   			    size_t size, int flags)
>   {
>   	struct sock *sk = sock->sk;
> +	struct j1939_sock *jsk = j1939_sk(sk);
>   	struct sk_buff *skb;
>   	struct j1939_sk_buff_cb *skcb;
>   	int ret = 0;
>   
> +	if (flags & MSG_ERRQUEUE)
> +		return sock_recv_errqueue(sock->sk, msg, size, SOL_CAN_J1939,
> +					  SCM_J1939_RECVERR);
> +
>   	skb = skb_recv_datagram(sk, flags, 0, &ret);
>   	if (!skb)
>   		return ret;
> @@ -713,6 +739,49 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
>   	return NULL;
>   }
>   
> +void j1939_sk_err_queue(struct j1939_session *session)
> +{
> +	struct sock *sk = session->sk;
> +	struct j1939_sock *jsk = j1939_sk(sk);
> +	struct j1939_pktinfo info;
> +	struct sock_exterr_skb *serr;
> +	struct sk_buff *skb;
> +
> +	if (!(jsk->state & J1939_SOCK_RECVERR))
> +		return;
> +
> +	skb = alloc_skb(sizeof(info), GFP_ATOMIC);
> +	if (!skb)
> +		return;
> +
> +	info.cookie = session->cookie;
> +	info.size = session->total_message_size;
> +	info.size_done = min(session->pkt.done * 7, info.size);
> +	skb_put_data(skb, &info, sizeof(info));
> +
> +	serr = SKB_EXT_ERR(skb);
> +	memset(serr, 0, sizeof(*serr));
> +	serr->ee.ee_errno = session->err;
> +	serr->ee.ee_origin = SO_EE_ORIGIN_TXSTATUS;
> +
> +	if (sock_queue_err_skb(sk, skb))
> +		kfree_skb(skb);
> +};
> +
> +void j1939_sk_err_queue_tx_status(struct j1939_session *session)
> +{
> +	struct sock *sk = session->sk;
> +	struct j1939_sock *jsk = j1939_sk(sk);
> +
> +	if (!(jsk->state & J1939_SOCK_RECV_TX_STATUS))
> +		return;
> +
> +	if (!session->pkt.done)
> +		return;
> +
> +	j1939_sk_err_queue(session);
> +};
> +
>   void j1939_sk_send_multi_abort(struct j1939_priv *priv, struct sock *sk,
>   			       int err)
>   {
> @@ -721,8 +790,9 @@ void j1939_sk_send_multi_abort(struct j1939_priv *priv, struct sock *sk,
>   	sk->sk_error_report(sk);
>   }
>   
> -static int j1939_sk_send_multi(struct j1939_priv *priv,  struct sock *sk,
> -			       struct msghdr *msg, size_t size)
> +static int j1939_sk_send_multi(struct j1939_priv *priv, struct sock *sk,
> +			       struct msghdr *msg, size_t size,
> +			       struct j1939_pktinfo *info)
>   
>   {
>   	struct j1939_sock *jsk = j1939_sk(sk);
> @@ -788,6 +858,7 @@ static int j1939_sk_send_multi(struct j1939_priv *priv,  struct sock *sk,
>   					ret = PTR_ERR(session);
>   					goto kfree_skb;
>   				}
> +				session->cookie = info->cookie;
>   			}
>   		} else {
>   			j1939_session_skb_queue(session, skb);
> @@ -845,6 +916,35 @@ static int j1939_sk_send_one(struct j1939_priv *priv,  struct sock *sk,
>   	return ret ? ret : size;
>   }
>   
> +static int j1939_sk_cmsg_send(struct sock *sk, struct msghdr *msg,
> +			      struct j1939_pktinfo *info)
> +{
> +	struct cmsghdr *cmsg;
> +
> +	for_each_cmsghdr(cmsg, msg) {
> +		if (!CMSG_OK(msg, cmsg))
> +			return -EINVAL;
> +
> +		if (cmsg->cmsg_level != SOL_CAN_J1939)
> +			continue;
> +		switch (cmsg->cmsg_type) {
> +		case SCM_J1939_PKTINFO:
> +		{
> +			struct j1939_pktinfo *tinfo;
> +
> +			if (cmsg->cmsg_len != CMSG_LEN(sizeof(struct j1939_pktinfo)))
> +				return -EINVAL;
> +			tinfo = (struct j1939_pktinfo *)CMSG_DATA(cmsg);
> +			memcpy(info, tinfo, sizeof(*info));
> +			break;
> +		}
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}
> +
>   static int j1939_sk_sendmsg(struct socket *sock, struct msghdr *msg,
>   			    size_t size)
>   {
> @@ -852,6 +952,7 @@ static int j1939_sk_sendmsg(struct socket *sock, struct msghdr *msg,
>   	struct j1939_sock *jsk = j1939_sk(sk);
>   	struct j1939_priv *priv;
>   	struct net_device *ndev;
> +	struct j1939_pktinfo info = {};
>   	int ifindex;
>   	int ret;
>   
> @@ -894,6 +995,12 @@ static int j1939_sk_sendmsg(struct socket *sock, struct msghdr *msg,
>   			return -EACCES;
>   	}
>   
> +	if (msg->msg_controllen) {
> +		ret = j1939_sk_cmsg_send(sk, msg, &info);
> +		if (unlikely(ret))
> +			return ret;
> +	}
> +
>   	ndev = dev_get_by_index(sock_net(sk), ifindex);
>   	if (!ndev)
>   		return -ENXIO;
> @@ -904,7 +1011,7 @@ static int j1939_sk_sendmsg(struct socket *sock, struct msghdr *msg,
>   
>   	if (size > 8)
>   		/* re-route via transport protocol */
> -		ret = j1939_sk_send_multi(priv, sk, msg, size);
> +		ret = j1939_sk_send_multi(priv, sk, msg, size, &info);
>   	else
>   		ret = j1939_sk_send_one(priv, sk, msg, size);
>   
> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 734b0fd23078..b9462e7483c8 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -261,6 +261,9 @@ static void __j1939_session_drop(struct j1939_session *session)
>   
>   static void j1939_session_destroy(struct j1939_session *session)
>   {
> +
> +	if (session->sk)
> +		j1939_sk_err_queue(session);
>   	j1939_session_list_lock(session->priv);
>   	j1939_session_list_del(session);
>   	j1939_session_list_unlock(session->priv);
> @@ -867,6 +870,7 @@ static void j1939_session_cancel(struct j1939_session *session,
>   
>   	WARN_ON_ONCE(!err);
>   
> +	session->err = j1939_xtp_abort_to_errno(priv, err);
>   	/* do not send aborts on incoming broadcasts */
>   	if (!j1939_cb_is_broadcast(&session->skcb))
>   		j1939_xtp_tx_abort(priv, &session->skcb, session->extd,
> @@ -874,8 +878,7 @@ static void j1939_session_cancel(struct j1939_session *session,
>   				   err, session->skcb.addr.pgn);
>   
>   	if (session->sk)
> -		j1939_sk_send_multi_abort(priv, session->sk,
> -					  j1939_xtp_abort_to_errno(priv, err));
> +		j1939_sk_send_multi_abort(priv, session->sk, session->err);
>   }
>   
>   static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
> @@ -950,9 +953,10 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
>   		u8 abort = skb->data[1];
>   
>   		j1939_session_timers_cancel(session);
> +		session->err = j1939_xtp_abort_to_errno(priv, abort);
>   		if (session->sk)
>   			j1939_sk_send_multi_abort(priv, session->sk,
> -						  j1939_xtp_abort_to_errno(priv, abort));
> +						  session->err);
>   	}
>   
>   	/* TODO: maybe cancel current connection
> @@ -1036,6 +1040,7 @@ j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb, bool extd)
>   			session->pkt.last = session->pkt.total;
>   		/* TODO: do not set tx here, do it in txtimer */
>   		session->pkt.tx = session->pkt.done;
> +		j1939_sk_err_queue_tx_status(session);
>   	}
>   
>   	session->last_cmd = dat[0];
> 

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
