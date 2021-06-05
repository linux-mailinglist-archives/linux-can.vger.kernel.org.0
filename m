Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121AB39C76B
	for <lists+linux-can@lfdr.de>; Sat,  5 Jun 2021 12:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFEK24 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 5 Jun 2021 06:28:56 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52380 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFEK2z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 5 Jun 2021 06:28:55 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 155AQeic092203;
        Sat, 5 Jun 2021 19:26:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp);
 Sat, 05 Jun 2021 19:26:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 155AQZhd092089
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 5 Jun 2021 19:26:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
References: <20210602151733.3630-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <265c1129-96f1-7bb1-1d01-b2b8cc5b1a42@hartkopp.net>
 <51ed3352-b5b0-03a1-ec25-faa368adcc46@i-love.sakura.ne.jp>
 <5e4693cf-4691-e7da-9a04-3e70cc449bf5@i-love.sakura.ne.jp>
 <e5a53bed-4333-bd99-ca3d-0e25dfb546e5@virtuozzo.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH v2] can: bcm/raw/isotp: use per module netdevice notifier
Message-ID: <54a5f451-05ed-f977-8534-79e7aa2bcc8f@i-love.sakura.ne.jp>
Date:   Sat, 5 Jun 2021 19:26:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e5a53bed-4333-bd99-ca3d-0e25dfb546e5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021/06/04 22:06, Kirill Tkhai wrote:
> Hi, Tetsuo,
> 
> On 04.06.2021 03:22, Tetsuo Handa wrote:
>> Adding Kirill for commit 328fbe747ad4622f ("net: Close race between
>> {un, }register_netdevice_notifier() and setup_net()/cleanup_net()").
>>
>> I'm proposing this patch because calling {,un}register_netdevice_notifier()
>> on every socket {initialization,destruction} is killing ability to
>> concurrently run cleanup_net() enough for khungtaskd to complain.
>>
>> You are referring something with raw_init() in the above commit.
>> What is your concern? (I'm asking you in case this patch breaks
>> something you mentioned.)
> 
> using global locks like pernet_ops_rwsem or even rtnl_mutex for such small
> entities as socket is a big evil. rtnl_mutex is already overloaded lock,
> and it mustn't be used in places, where this can easily be avoided.
> The same is for pernet_ops_rwsem. Netdevice notifier also mustn't
> be registered from pernet init.
> 
> People have to introduce their own fine-grain locks in their drivers and
> to stop using global locks, where it's possible.

I see. Then, this patch should be OK.

> 
> So, I like your patch with moving register_netdevice_notifier() into
> module init, since it goes in right direction. The only thing I would try
> to change is bcm_notifier_sequence, which looks a bit complex for me.
> 
> bcm_notifier()
> {
> 	spin_lock()
> 	list_for_each_entry_safe(notify, tmp, &bcm_notifier_list, list) {
> 		bcm_notifier_current = notify;
> 		spin_unlock();
> 		bcm_notify();
> 		spin_lock();
> 	}
> 	bcm_notifier_current = NULL;
> 	spin_unlock();
> 
> 	wake_up_all(&bcm_notifier_wait);
> }
> 
> bcm_release()
> {
> 	bool wait;
> 
> 	spin_lock();
> 	wait = (bcm_notifier_current == bo);
> 	list_del(&bo->notifier.list);
> 	spin_unlock();
> 
> 	if (wait)
> 		wait_event(bcm_notifier_wait, bcm_notifier_current != bo);
> 
> }

Well, I think this list_for_each_entry_safe() usage is not safe, for nothing
prevents "tmp" from being immediately released by bcm_release(). I think

bcm_release()
{
	spin_lock();
	list_del(&bo->notifier.list);
	spin_unlock();

	wait_event(bcm_notifier_wait, !bcm_notifier_current);
}

should be safe, but this will wait for all bcm_notifier_list items
if bcm_notifier() is running.

I think deferring list_del() if bcm_notifier_current == bo and preserving
plain list_for_each_entry() will be easier, for "notify"->next can retain a
valid pointer for resuming list_for_each_entry() until "notify" is removed
by list_del().

> 
> Kirill
> 
> P.S. Also, that approach with single notifier allows to do optimization
> like:
> 
> bcm_notifier(msg)
> {
> 	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
>                 return NOTIFY_DONE;
> 
> 	list_for_.... {
> 	}
> }
> 
> Otherwise, it's rather strange to iterate many notifiers, no one of that will
> actually be called if msg = {NETDEV_UP, NETDEV_CHANGE, etc}.

OK. I take this part.

Assuming that

  bcm_notify() will not take many seconds

and

  NETDEV_UNREGISTER/NETDEV_DOWN events will not happen every jiffies

, I choose optimistic "sleep for 1 jiffies and recheck" approach rather than
"use waitqueue and let bcm_notifier() check whether bcm_release() needs to be
woken up" approach.

Updated patch is shown below.


From 12c61ae3d06889c9bbc414f0230c05dc630f6409 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 5 Jun 2021 19:18:21 +0900
Subject: [PATCH v2] can: bcm/raw/isotp: use per module netdevice notifier

syzbot is reporting hung task at register_netdevice_notifier() [1] and
unregister_netdevice_notifier() [2], for cleanup_net() might perform
time consuming operations while CAN driver's raw/bcm/isotp modules are
calling {register,unregister}_netdevice_notifier() on each socket.

Change raw/bcm/isotp modules to call register_netdevice_notifier() from
module's __init function and call unregister_netdevice_notifier() from
module's __exit function, as with gw/j1939 modules are doing.

Link: https://syzkaller.appspot.com/bug?id=391b9498827788b3cc6830226d4ff5be87107c30 [1]
Link: https://syzkaller.appspot.com/bug?id=1724d278c83ca6e6df100a2e320c10d991cf2bce [2]
Reported-by: syzbot <syzbot+355f8edb2ff45d5f95fa@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+0f1827363a305f74996f@syzkaller.appspotmail.com>
Tested-by: syzbot <syzbot+355f8edb2ff45d5f95fa@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/bcm.c   | 59 +++++++++++++++++++++++++++++++++++-----------
 net/can/isotp.c | 61 +++++++++++++++++++++++++++++++++++++-----------
 net/can/raw.c   | 62 ++++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 142 insertions(+), 40 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 909b9e684e04..f00176b2a6c3 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -125,7 +125,7 @@ struct bcm_sock {
 	struct sock sk;
 	int bound;
 	int ifindex;
-	struct notifier_block notifier;
+	struct list_head notifier;
 	struct list_head rx_ops;
 	struct list_head tx_ops;
 	unsigned long dropped_usr_msgs;
@@ -133,6 +133,10 @@ struct bcm_sock {
 	char procname [32]; /* inode number in decimal with \0 */
 };
 
+static LIST_HEAD(bcm_notifier_list);
+static DEFINE_SPINLOCK(bcm_notifier_lock);
+static struct bcm_sock *bcm_busy_notifier;
+
 static inline struct bcm_sock *bcm_sk(const struct sock *sk)
 {
 	return (struct bcm_sock *)sk;
@@ -1378,20 +1382,15 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 /*
  * notification handler for netdevice status changes
  */
-static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
-			void *ptr)
+static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
+		       struct net_device *dev)
 {
-	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-	struct bcm_sock *bo = container_of(nb, struct bcm_sock, notifier);
 	struct sock *sk = &bo->sk;
 	struct bcm_op *op;
 	int notify_enodev = 0;
 
 	if (!net_eq(dev_net(dev), sock_net(sk)))
-		return NOTIFY_DONE;
-
-	if (dev->type != ARPHRD_CAN)
-		return NOTIFY_DONE;
+		return;
 
 	switch (msg) {
 
@@ -1426,7 +1425,28 @@ static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
 				sk->sk_error_report(sk);
 		}
 	}
+}
 
+static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
+			void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+
+	if (dev->type != ARPHRD_CAN)
+		return NOTIFY_DONE;
+	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
+		return NOTIFY_DONE;
+	if (unlikely(bcm_busy_notifier)) /* Check for reentrant bug. */
+		return NOTIFY_DONE;
+
+	spin_lock(&bcm_notifier_lock);
+	list_for_each_entry(bcm_busy_notifier, &bcm_notifier_list, notifier) {
+		spin_unlock(&bcm_notifier_lock);
+		bcm_notify(bcm_busy_notifier, msg, dev);
+		spin_lock(&bcm_notifier_lock);
+	}
+	bcm_busy_notifier = NULL;
+	spin_unlock(&bcm_notifier_lock);
 	return NOTIFY_DONE;
 }
 
@@ -1446,9 +1466,9 @@ static int bcm_init(struct sock *sk)
 	INIT_LIST_HEAD(&bo->rx_ops);
 
 	/* set notifier */
-	bo->notifier.notifier_call = bcm_notifier;
-
-	register_netdevice_notifier(&bo->notifier);
+	spin_lock(&bcm_notifier_lock);
+	list_add_tail(&bo->notifier, &bcm_notifier_list);
+	spin_unlock(&bcm_notifier_lock);
 
 	return 0;
 }
@@ -1471,7 +1491,14 @@ static int bcm_release(struct socket *sock)
 
 	/* remove bcm_ops, timer, rx_unregister(), etc. */
 
-	unregister_netdevice_notifier(&bo->notifier);
+	spin_lock(&bcm_notifier_lock);
+	while (bcm_busy_notifier == bo) {
+		spin_unlock(&bcm_notifier_lock);
+		schedule_timeout_uninterruptible(1);
+		spin_lock(&bcm_notifier_lock);
+	}
+	list_del(&bo->notifier);
+	spin_unlock(&bcm_notifier_lock);
 
 	lock_sock(sk);
 
@@ -1692,6 +1719,10 @@ static struct pernet_operations canbcm_pernet_ops __read_mostly = {
 	.exit = canbcm_pernet_exit,
 };
 
+static struct notifier_block canbcm_notifier = {
+	.notifier_call = bcm_notifier
+};
+
 static int __init bcm_module_init(void)
 {
 	int err;
@@ -1705,12 +1736,14 @@ static int __init bcm_module_init(void)
 	}
 
 	register_pernet_subsys(&canbcm_pernet_ops);
+	register_netdevice_notifier(&canbcm_notifier);
 	return 0;
 }
 
 static void __exit bcm_module_exit(void)
 {
 	can_proto_unregister(&bcm_can_proto);
+	unregister_netdevice_notifier(&canbcm_notifier);
 	unregister_pernet_subsys(&canbcm_pernet_ops);
 }
 
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 253b24417c8e..be6183f8ca11 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -143,10 +143,14 @@ struct isotp_sock {
 	u32 force_tx_stmin;
 	u32 force_rx_stmin;
 	struct tpcon rx, tx;
-	struct notifier_block notifier;
+	struct list_head notifier;
 	wait_queue_head_t wait;
 };
 
+static LIST_HEAD(isotp_notifier_list);
+static DEFINE_SPINLOCK(isotp_notifier_lock);
+static struct isotp_sock *isotp_busy_notifier;
+
 static inline struct isotp_sock *isotp_sk(const struct sock *sk)
 {
 	return (struct isotp_sock *)sk;
@@ -1013,7 +1017,14 @@ static int isotp_release(struct socket *sock)
 	/* wait for complete transmission of current pdu */
 	wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
 
-	unregister_netdevice_notifier(&so->notifier);
+	spin_lock(&isotp_notifier_lock);
+	while (isotp_busy_notifier == so) {
+		spin_unlock(&isotp_notifier_lock);
+		schedule_timeout_uninterruptible(1);
+		spin_lock(&isotp_notifier_lock);
+	}
+	list_del(&so->notifier);
+	spin_unlock(&isotp_notifier_lock);
 
 	lock_sock(sk);
 
@@ -1317,21 +1328,16 @@ static int isotp_getsockopt(struct socket *sock, int level, int optname,
 	return 0;
 }
 
-static int isotp_notifier(struct notifier_block *nb, unsigned long msg,
-			  void *ptr)
+static void isotp_notify(struct isotp_sock *so, unsigned long msg,
+			 struct net_device *dev)
 {
-	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-	struct isotp_sock *so = container_of(nb, struct isotp_sock, notifier);
 	struct sock *sk = &so->sk;
 
 	if (!net_eq(dev_net(dev), sock_net(sk)))
-		return NOTIFY_DONE;
-
-	if (dev->type != ARPHRD_CAN)
-		return NOTIFY_DONE;
+		return;
 
 	if (so->ifindex != dev->ifindex)
-		return NOTIFY_DONE;
+		return;
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
@@ -1357,7 +1363,28 @@ static int isotp_notifier(struct notifier_block *nb, unsigned long msg,
 			sk->sk_error_report(sk);
 		break;
 	}
+}
 
+static int isotp_notifier(struct notifier_block *nb, unsigned long msg,
+			  void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+
+	if (dev->type != ARPHRD_CAN)
+		return NOTIFY_DONE;
+	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
+		return NOTIFY_DONE;
+	if (unlikely(isotp_busy_notifier)) /* Check for reentrant bug. */
+		return NOTIFY_DONE;
+
+	spin_lock(&isotp_notifier_lock);
+	list_for_each_entry(isotp_busy_notifier, &isotp_notifier_list, notifier) {
+		spin_unlock(&isotp_notifier_lock);
+		isotp_notify(isotp_busy_notifier, msg, dev);
+		spin_lock(&isotp_notifier_lock);
+	}
+	isotp_busy_notifier = NULL;
+	spin_unlock(&isotp_notifier_lock);
 	return NOTIFY_DONE;
 }
 
@@ -1394,8 +1421,9 @@ static int isotp_init(struct sock *sk)
 
 	init_waitqueue_head(&so->wait);
 
-	so->notifier.notifier_call = isotp_notifier;
-	register_netdevice_notifier(&so->notifier);
+	spin_lock(&isotp_notifier_lock);
+	list_add_tail(&so->notifier, &isotp_notifier_list);
+	spin_unlock(&isotp_notifier_lock);
 
 	return 0;
 }
@@ -1442,6 +1470,10 @@ static const struct can_proto isotp_can_proto = {
 	.prot = &isotp_proto,
 };
 
+static struct notifier_block canisotp_notifier = {
+	.notifier_call = isotp_notifier
+};
+
 static __init int isotp_module_init(void)
 {
 	int err;
@@ -1451,6 +1483,8 @@ static __init int isotp_module_init(void)
 	err = can_proto_register(&isotp_can_proto);
 	if (err < 0)
 		pr_err("can: registration of isotp protocol failed\n");
+	else
+		register_netdevice_notifier(&canisotp_notifier);
 
 	return err;
 }
@@ -1458,6 +1492,7 @@ static __init int isotp_module_init(void)
 static __exit void isotp_module_exit(void)
 {
 	can_proto_unregister(&isotp_can_proto);
+	unregister_netdevice_notifier(&canisotp_notifier);
 }
 
 module_init(isotp_module_init);
diff --git a/net/can/raw.c b/net/can/raw.c
index 139d9471ddcf..ac96fc210025 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -83,7 +83,7 @@ struct raw_sock {
 	struct sock sk;
 	int bound;
 	int ifindex;
-	struct notifier_block notifier;
+	struct list_head notifier;
 	int loopback;
 	int recv_own_msgs;
 	int fd_frames;
@@ -95,6 +95,10 @@ struct raw_sock {
 	struct uniqframe __percpu *uniq;
 };
 
+static LIST_HEAD(raw_notifier_list);
+static DEFINE_SPINLOCK(raw_notifier_lock);
+static struct raw_sock *raw_busy_notifier;
+
 /* Return pointer to store the extra msg flags for raw_recvmsg().
  * We use the space of one unsigned int beyond the 'struct sockaddr_can'
  * in skb->cb.
@@ -263,21 +267,16 @@ static int raw_enable_allfilters(struct net *net, struct net_device *dev,
 	return err;
 }
 
-static int raw_notifier(struct notifier_block *nb,
-			unsigned long msg, void *ptr)
+static void raw_notify(struct raw_sock *ro, unsigned long msg,
+		       struct net_device *dev)
 {
-	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-	struct raw_sock *ro = container_of(nb, struct raw_sock, notifier);
 	struct sock *sk = &ro->sk;
 
 	if (!net_eq(dev_net(dev), sock_net(sk)))
-		return NOTIFY_DONE;
-
-	if (dev->type != ARPHRD_CAN)
-		return NOTIFY_DONE;
+		return;
 
 	if (ro->ifindex != dev->ifindex)
-		return NOTIFY_DONE;
+		return;
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
@@ -305,7 +304,28 @@ static int raw_notifier(struct notifier_block *nb,
 			sk->sk_error_report(sk);
 		break;
 	}
+}
+
+static int raw_notifier(struct notifier_block *nb, unsigned long msg,
+			void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+
+	if (dev->type != ARPHRD_CAN)
+		return NOTIFY_DONE;
+	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
+		return NOTIFY_DONE;
+	if (unlikely(raw_busy_notifier)) /* Check for reentrant bug. */
+		return NOTIFY_DONE;
 
+	spin_lock(&raw_notifier_lock);
+	list_for_each_entry(raw_busy_notifier, &raw_notifier_list, notifier) {
+		spin_unlock(&raw_notifier_lock);
+		raw_notify(raw_busy_notifier, msg, dev);
+		spin_lock(&raw_notifier_lock);
+	}
+	raw_busy_notifier = NULL;
+	spin_unlock(&raw_notifier_lock);
 	return NOTIFY_DONE;
 }
 
@@ -334,9 +354,9 @@ static int raw_init(struct sock *sk)
 		return -ENOMEM;
 
 	/* set notifier */
-	ro->notifier.notifier_call = raw_notifier;
-
-	register_netdevice_notifier(&ro->notifier);
+	spin_lock(&raw_notifier_lock);
+	list_add_tail(&ro->notifier, &raw_notifier_list);
+	spin_unlock(&raw_notifier_lock);
 
 	return 0;
 }
@@ -351,7 +371,14 @@ static int raw_release(struct socket *sock)
 
 	ro = raw_sk(sk);
 
-	unregister_netdevice_notifier(&ro->notifier);
+	spin_lock(&raw_notifier_lock);
+	while (raw_busy_notifier == ro) {
+		spin_unlock(&raw_notifier_lock);
+		schedule_timeout_uninterruptible(1);
+		spin_lock(&raw_notifier_lock);
+	}
+	list_del(&ro->notifier);
+	spin_unlock(&raw_notifier_lock);
 
 	lock_sock(sk);
 
@@ -889,6 +916,10 @@ static const struct can_proto raw_can_proto = {
 	.prot       = &raw_proto,
 };
 
+static struct notifier_block canraw_notifier = {
+	.notifier_call = raw_notifier
+};
+
 static __init int raw_module_init(void)
 {
 	int err;
@@ -898,6 +929,8 @@ static __init int raw_module_init(void)
 	err = can_proto_register(&raw_can_proto);
 	if (err < 0)
 		pr_err("can: registration of raw protocol failed\n");
+	else
+		register_netdevice_notifier(&canraw_notifier);
 
 	return err;
 }
@@ -905,6 +938,7 @@ static __init int raw_module_init(void)
 static __exit void raw_module_exit(void)
 {
 	can_proto_unregister(&raw_can_proto);
+	unregister_netdevice_notifier(&canraw_notifier);
 }
 
 module_init(raw_module_init);
-- 
2.18.4

