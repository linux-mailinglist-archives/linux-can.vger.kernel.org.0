Return-Path: <linux-can+bounces-2707-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90309A22814
	for <lists+linux-can@lfdr.de>; Thu, 30 Jan 2025 05:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAA8162DA2
	for <lists+linux-can@lfdr.de>; Thu, 30 Jan 2025 04:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17672129A78;
	Thu, 30 Jan 2025 04:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tmnRk487"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-16.smtpout.orange.fr [193.252.22.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D206D2FB
	for <linux-can@vger.kernel.org>; Thu, 30 Jan 2025 04:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738211343; cv=none; b=hP6vMlyFM9y7pkGxdP2e0sa3gX+KEHF9ACQgEYxGdnPCYdhu4BVVeKtVfsi7Q4sNC4z7+2nmbG1orRuJR8b/xf2rLIcbo8BveDNGKRCke9XF1C20ZW15sXPkaR10tY7hnWTSdsWWyd6V+fvfMSOvQmu33MLaFxCUA1CASriOl6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738211343; c=relaxed/simple;
	bh=TtKzogLZCpkawLL8WLueKsPVQlbR8FB+1auOI3PaIfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+pM6wBZYgknnooOeLR8fjnJ4edcgVMCRBZi2BBFoBEpJ+ACHel3Mh4Xbj5D0aNqYeZZ6v1C8hOYb0r4MltO4OT19GijG2e6NZThn9pJVFCkzROHHcINxsT7zx9TPEkU2Bxs3Qs3GXg2Fq2UlBCaJeV1ujPsFqMEvIFqQv8Lxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tmnRk487; arc=none smtp.client-ip=193.252.22.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id dMAWtuyKNIcMJdMAbtCEH0; Thu, 30 Jan 2025 05:28:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1738211331;
	bh=dVNPLiuRoUat06hkilHxj6OxL9owF2RAFc9rDb8qVxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=tmnRk487HoNZKebWQLZdJmcd/uEPdr1AHT+eZ7oZFXt2oaVcnOMECYQfwDDkFoMXd
	 PaxW82lV19RMOZtGkd4PRpjOyPgzoqcOm4fPWk7BN/yIdiZ5NyI9i5V+kMUpqY2qo2
	 7D2fdBPWUjLTzTgZfRMIX8CnIKLIa+29dxc48Vt1ROvoyfuD9POxR1zgzOul7vYqox
	 97Djt3ZhrNHe7TYrkYzWFmspoRS4r8uNR5bnAHzfc17oXXA/zR8T3eNQgil6vsPTPz
	 kY8eTiZfCEgzdDZwAsu3BYKNZvmfvoP1tulLaQUFN5VPaiq+MlLdg4Wg04ocF9ZNs+
	 855hIvO+wy46Q==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 30 Jan 2025 05:28:51 +0100
X-ME-IP: 124.33.176.97
Message-ID: <09bb99b8-56fb-428e-b54d-c49097ca93fa@wanadoo.fr>
Date: Thu, 30 Jan 2025 13:28:43 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Issue] Bosch D_CAN echo skb occupied error
To: "Schmidt, Stefan" <schmidtssstefan@siemens-healthineers.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
References: <AM8PR05MB8052EFD0609D2F65BECBE1AE8FE32@AM8PR05MB8052.eurprd05.prod.outlook.com>
 <CAMZ6RqKgFG=zhQTDWdrGHH1Sey1mLNFWQFAjTCcrXUgPdKTYrQ@mail.gmail.com>
 <AM8PR05MB8052972C60F231BAC9CA1E678FEC2@AM8PR05MB8052.eurprd05.prod.outlook.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <AM8PR05MB8052972C60F231BAC9CA1E678FEC2@AM8PR05MB8052.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+CC: Dario

On 28/01/2025 at 00:44, Schmidt, Stefan wrote:
> Dear Vincent,
> 
>> -----Ursprüngliche Nachricht-----
>> Von: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> Gesendet: Freitag, 24. Januar 2025 15:16
>> An: Schmidt, Stefan <schmidtssstefan@siemens-healthineers.com>
>> Cc: linux-can@vger.kernel.org
>> Betreff: Re: [Issue] Bosch D_CAN echo skb occupied error

(...)

>>
>>> Context:
>>> Recently, we updated our kernel from 4.14 to 6.1.43 and our Debian from
>> 10 to 12.
>>> The system runs on an Altera Cyclone V, which has two Bosch D_CAN CAN
>> Controllers on board. We use both. Additionally, it is a dual core system with
>> two Arm cores.
>>>
>>> Issue:
>>> After the update, I saw that both CAN devices sporadically print the message
>> "BUG! echo_skb %d is occupied!" once into the syslog, with %d always being
>> index 0.
>>> From there on the affected device was unable to send any messages. A
>> restart of the device (ifdown/up) recovered the problem.
>>>
>>> Steps Taken:
>>> After heavily polluting the driver with trace points, I found out that in this
>> case, the echo socket buffer is indeed still occupied by an old message on index
>> 0.
>>> Looking at the preceding usage of index 0, I saw that both functions
>> c_can_start_xmit and c_can_do_tx  (drivers/net/can/c_can/c_can_main.c )
>> were executed on different cores at the same time.
>>> One was called by the tx-interrupt of the CAN controller and was scheduled
>> on CPU0.
>>> The other one was called by the application / network layer and was
>> scheduled on CPU1.
>>> As both functions operate on the same resources (variables in RAM and CAN
>> controller registers), I think that there should be some kind of synchronization
>> mechanism, but I did not find any in the code.
>>>
>>> Theory:
>>> I think that the caching mechanism, that was introduced somewhen after
>> the 4.14 version of the kernel, can get compromised by this parallel execution.
>>> In the beginning of c_can_start_xmit, the function checks if there is a wrap
>> around in the buffer. If this is the case, the message just gets prepared,
>> everything gets written to the chip, but the final transmission request is not
>> set.
>>> ```c
>>> // (1) drivers/net/can/c_can/c_can_main.c - c_can_start_xmit cmd &=
>>> ~IF_COMM_TXRQST; /* Cache the message */ ``` In the end of
>>> c_can_start_xmit this command gets written to the CAN controller.
>>> ```c
>>> // (2) drivers/net/can/c_can/c_can_main.c - c_can_start_xmit
>>> c_can_object_put(dev, IF_TX, obj, cmd); ``` The final trigger to send
>>> the message shall then be set in the tx-interrupt, as soon as message from
>> object index 15 (last index) was processed, because otherwise, the new
>> message on index 0 would bypass the one on index 15 and change the order in
>> which they are put on the bus.
>>> ```c
>>> // (3) drivers/net/can/c_can/c_can_main.c - c_can_do_tx
>>> c_can_object_put(dev, IF_NAPI, obj, IF_COMM_TXRQST); ``` My theory is,
>>> that as it is possible that both functions run parallel on different CPUs, I think
>> that it is possible that this can happen that it happens in this order (1) -> (3) ->
>> (2). Which leads to the situation that the transmission request bit is
>> immediately reset after being set.
>>> To support my theory, I put a spinlock around both critical code sections. As
>> of now, this seems to properly solve the issue, but I am aware that this is
>> probably the clumsiest way to do it.
>>>
>>> Request:
>>> I am reaching out to you because I have not found anyone else with a similar
>> problem on the internet.
>>> It would be great if you could share your thought about this problem and
>> maybe give some hints for a cleaner solution.
>>>
>>> Additional Details:
>>> Please find my clumsy fix with the spinlock below. I don't think that it is
>> ready to be merged to any official repository, but maybe it is a short-term help
>> for someone who is in a similar situation.
>>
>> So, theoretically, it should be possible to have a lockless queue under the
>> conditions that:
>>
>>   - there is only one reader at a time
>>   - there is only one writer at a time
>>   - the queue size is a power of 2
>>
> 
> Implementing another queue length than power of 2 in hardware is probably a pain, so I think this point is always true.

Actually, the queue size is configured in software through
c_can_driver_data->msg_obj_num. Example:


https://elixir.bootlin.com/linux/v6.13/source/drivers/net/can/c_can/c_can_platform.c#L196

And all the values for D_CAN are either 32 or 64.

> Maybe it can come to the problem even on single core systems. Is it possible that the TX soft-irq can interrupt the start_xmit, or is this somehow scheduled atomic?
> If it is possible, then the lock is also needed on single core systems.

Not sure 100%, but I can imagine this appearing on single core systems
as well if the scheduler decides to stop in the middle of c_can_do_tx().

It is clear that c_can_start_xmit() and c_can_do_tx() are racing between
each other. So let's go back to the lockless queue topic, and see what
could have gone wrong. As established the queue size is not the issue.

So it means that c_can_start_xmit() and c_can_do_tx() are doing
concurrent read and writes as corroborated by your observations and
analysis.

On important aspect of the lockless queue is the self discipline.
Because it is lockless, the writer should monitor the occupancy of the
queue and stop writing when it is full. Similarly, the reader should
first free the slots *before* notifying the reader that these slots
became available again.

If the writer stops the queue too late or if the reader resumes the
queue too early, bad things happen.

Back to the network queue, this logic will be controlled using the
netif_wake_queue() and netif_stop_queue():

  - just before the head reaches the queue, c_can_start_xmit() must call
    netif_stop_queue() so that the network frame work stop calling that
    function

  - once c_can_do_tx() finishes reading the queue, it calls
    netif_wake_queue() to notify the network framework that it is safe
    again to call c_can_start_xmit().

>> This design will then abuse the C unsigned integer wraparound property. The
>> c_can/d_can meets all above requirements, so normally, no locks are needed
>> here.
>>
>> So I think that the core issue is somewhere else. Looking at the recent
>> commits, [1] and [2] caught my attention:
>>
>> [1] commit 387da6bc7a82 ("can: c_can: cache frames to operate as a true
>> FIFO")
>> https://git.kernel.org/torvalds/c/387da6bc7a82
>>
>> [2] commit 81d192c2ce74 ("can: c_can: don't cache TX messages for C_CAN
>> cores")
>> https://git.kernel.org/torvalds/c/81d192c2ce74
>>
>> Those two are present in 6.1.x on which you are having your problem.
>>
>> What triggers me the most is the fact that the D_CAN, on which you are having
>> your problems, have a special if condition:
>>
>>
>> https://elixir.bootlin.com/linux/v6.12/source/drivers/net/can/c_can/c_can.h
>> #L244
>>
>> In addition, [2] says that, I quote:
>>
>>   the optimization introduced in [1] doesn't properly work on
>>   C_CAN, but on D_CAN IP cores. The exact reasons are still
>>   unknown.
>>
>> The other part of the queue implementation looks good to me. Only this
>> c_can_get_tx_free() caught my attention.
>>
>> Can you try to revert above commits [1] and [2] and tell us if you still have the
>> issue?
> 
> Unfortunately, I don't have enough time for those tests,

With the good git commands, reverting commits should be an easy task.
Example working on the stable tree:

  git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
  cd linux
  git checkout v6.1.43
  git revert 81d192c2ce74 # revert [2]
  git revert 387da6bc7a82 # revert [1]
  editor drivers/net/can/c_can/c_can_main.c # resolve the conflict
  git add drivers/net/can/c_can/c_can_main.c # add conflict resolution
  git revert --continue # continue and commit the revert of [1]

(this is FYI, your analysis gave enough information so that this revert
is not necessary anymore).

> but I am quite sure that they are the reason, because the code looks almost like in 4.14 after reverting those changes.
> Those changes [1] and [2] introduced write access to the TX buffer in the tx-irq (c_can_do_tx). This was not the case before those changes.
> Maybe it was not considered that the function c_can_do_tx can / is called from another context.
> Maybe, someone who uses the C_CAN had the same problems as me and therefore disabled the caching mechanism.
> 
> From my point of view, those resources need to be protected by concurrent access:
> - tx_ring->tail: This is incremented by the tx-irq. If it becomes 0 (message on index 15 was sent), it checks if other messages were cached by looking on tx_ring->head. If head is greater 0, it will set the TX request bit for all cached messages by calling c_can_object_put.
> - tx_ring->head: This is incremented by the sending routine. If it becomes 0 and tail is still greater than 0 (there are still messages in the last objects that are waiting to be sent), the message must be cached (TX request must not be set), because the controller sends the messages object with the lowest index first. If it wasn’t cached, it would bypass the messages in the objects with the higher index.
> - Any call to c_can_object_put / c_can_inval_tx_object / c_can_object_get, because they all call c_can_obj_update which sets a register and busy waits for the transaction to complete
> 
> Probably it is not necessary to protect the first half of the tx-irq:
> ```c
> static void c_can_do_tx(struct net_device *dev)
> {
> 	struct c_can_priv *priv = netdev_priv(dev);
> 	struct c_can_tx_ring *tx_ring = &priv->tx;
> 	struct net_device_stats *stats = &dev->stats;
> 	u32 idx, obj, pkts = 0, bytes = 0, pend;
> 	u8 tail;
> 
> 	if (priv->msg_obj_tx_last > 32)
> 		pend = priv->read_reg32(priv, C_CAN_INTPND3_REG);
> 	else
> 		pend = priv->read_reg(priv, C_CAN_INTPND2_REG);
> 
> 	while ((idx = ffs(pend))) {
> 		idx--;
> 		pend &= ~BIT(idx);
> 		obj = idx + priv->msg_obj_tx_first;
> 
> 		/* We use IF_NAPI interface instead of IF_TX because we
> 		 * are called from c_can_poll(), which runs inside
> 		 * NAPI. We are not transmitting.
> 		 */
> 		c_can_inval_tx_object(dev, IF_NAPI, obj);
> 		bytes += can_get_echo_skb(dev, idx, NULL);
> 		pkts++;
> 	}
> 
> 	if (!pkts)
> 		return;
> 
> ////////////// spinlock starting here
> 
> 	tx_ring->tail += pkts;
> 	if (c_can_get_tx_free(priv, tx_ring)) {
> 		/* Make sure that anybody stopping the queue after
> 		 * this sees the new tx_ring->tail.
> 		 */
> 		smp_mb();
> ////////////// Do we get a problem here because this might call the send routine?! I have no idea. Maybe this should be moved to the end of the function and be removed out of the spin lock section
> 		netif_wake_queue(priv->dev); // is this the equivalent to stop queue?

Yes! It is netif_stop_queue().

> 	}
> 
> 	stats->tx_bytes += bytes;
> 	stats->tx_packets += pkts;
> 
> 	tail = c_can_get_tx_tail(tx_ring);
> 	if (priv->type == BOSCH_D_CAN && tail == 0) {
This bothers me the most. This check occurs *after* the call to
netif_wake_queue() so anything in this if block is not guarded anymore
and can race against c_can_start_xmit().

> 		u8 head = c_can_get_tx_head(tx_ring);
> 
> 		/* Start transmission for all cached messages */
> 		for (idx = tail; idx < head; idx++) {
> 			obj = idx + priv->msg_obj_tx_first;
> 			c_can_object_put(dev, IF_NAPI, obj, IF_COMM_TXRQST);
> 		}
> 	}
> }
> ```
> 
> 
> In the sending routine, I think most stuff needs to be protected. Some parts could be rearranged to reduce the amount of code in the critical area.
> ```c
> static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
> 				    struct net_device *dev)
> {
> 	struct can_frame *frame = (struct can_frame *)skb->data;
> 	struct c_can_priv *priv = netdev_priv(dev);
> 	struct c_can_tx_ring *tx_ring = &priv->tx;
> 	u32 idx, obj, cmd = IF_COMM_TX;
> 
> 	if (can_dev_dropped_skb(dev, skb))
> 		return NETDEV_TX_OK;
> 
> 	if (c_can_tx_busy(priv, tx_ring))
> 		return NETDEV_TX_BUSY;
> 
> /////// spinlock starting here
> 	idx = c_can_get_tx_head(tx_ring);   /// this probably doesn’t need the spinlock yet, because it just reads and the tx-irq does not modify
> 	tx_ring->head++; // this needs to be protected because tx-irq will use it to decide how many tx request bits it needs to set
> 	if (c_can_get_tx_free(priv, tx_ring) == 0) // if this wasn’t protected, the queue could possibly be stopped although a message object just became free, which would not be too bad
> 		netif_stop_queue(dev);
> 
> 	if (idx < c_can_get_tx_tail(tx_ring)) // this needs to be protected
> 		cmd &= ~IF_COMM_TXRQST; /* Cache the message */
> 
> 	/* Store the message in the interface so we can call
> 	 * can_put_echo_skb(). We must do this before we enable
> 	 * transmit as we might race against do_tx().
> 	 */
> 	c_can_setup_tx_object(dev, IF_TX, frame, idx); // this needs to be protected because it calls  c_can_inval_tx_object
> 	can_put_echo_skb(skb, dev, idx, 0); // this probably doesn’t need protection
> 	obj = idx + priv->msg_obj_tx_first;
> 	c_can_object_put(dev, IF_TX, obj, cmd);  // this needs protection again
> 
> 	return NETDEV_TX_OK;
> }
> ```
> 
> I have done extensive tests with my patch, and it works well in my system. For me, it would be sufficient :-D.
> In the meantime, I found that another driver had the same problem. They chose a similar solution
> https://lore.kernel.org/lkml/20180327162802.559928021@linuxfoundation.org/

Putting spinlock will of course solves your issue, but it just papering
over the root cause. Here we need to find where the queue wake/stop
logic went wrong.

>>> Thank you in advance for your time and assistance. I look forward to hearing
>> your suggestions or advice.
>>
>> Thank you for the detailed report. Let me ask you: do you want to write the
>> final patch? If yes, we can guide you into the process.
> 
> It would be an honour to do this :-)

Great. Have a look at these:


https://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-patch-to-the-linux-kernel-and-responding-to-feedback/
  https://www.kernel.org/doc/html/latest/process/submitting-patches.html

When you describe your changes in your patch, go for conciseness. No
need for the politeness, go strait to the point.

A good way to describe the race condition is through some ASCII art
diagram, something like this:

         CPU 1                   CPU 2

           |                       |
    c_can_do_tx()                  |
           |                       |
      netif_wake_queue()           |
           |                       |
           |               c_can_start_xmit()
           |                       |
      c_can_object_put()     can_put_echo_skb()
           |                       |
           |                       |
           v                       v

If you have a dmesg error log, it is also good to attach it at the
bottom of your patch description.

Have a look at:

  git log --grep="race condition"

to see how people usually describe their patch when fixing a race condition.


Yours sincerely,
Vincent Mailhol


