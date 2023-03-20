Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F046C1BAC
	for <lists+linux-can@lfdr.de>; Mon, 20 Mar 2023 17:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjCTQb4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 20 Mar 2023 12:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjCTQbg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Mar 2023 12:31:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C572D171
        for <linux-can@vger.kernel.org>; Mon, 20 Mar 2023 09:24:10 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1peIIr-0001xx-0N; Mon, 20 Mar 2023 17:24:09 +0100
Received: from pengutronix.de (unknown [IPv6:2a00:20:c056:7805:6eff:9f8d:27d7:d42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E67F2197ADE;
        Mon, 20 Mar 2023 16:24:07 +0000 (UTC)
Date:   Mon, 20 Mar 2023 17:24:06 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [RFC PATCH v2] can: isotp: add module parameter for maximum pdu
 size
Message-ID: <20230320162406.5mkbvcmyx7nyqvjc@pengutronix.de>
References: <20230313172510.3851-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4kqlnu2j3jl2hfjp"
Content-Disposition: inline
In-Reply-To: <20230313172510.3851-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--4kqlnu2j3jl2hfjp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.03.2023 18:25:10, Oliver Hartkopp wrote:
> With ISO 15765-2:2016 the PDU size is not limited to 2^12 - 1 (4095) bytes
> but can be represented as a 32 bit unsigned integer value which allows
> 2^32 - 1 bytes (~4GB). The use-cases like automotive unified diagnostic
> services (UDS) and flashing of ECUs still use the small static buffers
> which are provided at socket creation time.
>=20
> When a use-case requires to transfer PDUs up to 1025 kByte the maximum
> PDU size can now be extended by setting the module parameter max_pdu_size.
> The extended size buffers are only allocated on a per-socket/connection
> base when needed at run-time.
>=20
> Link: https://github.com/raspberrypi/linux/issues/5371
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

See comments inline

> ---
>=20
> v2: limit the minimum 'max_pdu_size' to 4095 to maintain the classic beha=
vior
>     before ISO 15765-2:2016
>=20
> net/can/isotp.c | 65 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 56 insertions(+), 9 deletions(-)
>=20
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 9bc344851704..8a5d278c8bf1 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -83,14 +83,25 @@ MODULE_ALIAS("can-proto-6");
>  			 (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG) : \
>  			 (CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG))
> =20
>  /* ISO 15765-2:2016 supports more than 4095 byte per ISO PDU as the FF_D=
L can
>   * take full 32 bit values (4 Gbyte). We would need some good concept to=
 handle
> - * this between user space and kernel space. For now increase the static=
 buffer
> - * to something about 64 kbyte to be able to test this new functionality.
> + * this between user space and kernel space. For now set the static buff=
er to
> + * something about 8 kbyte to be able to test this new functionality.
>   */
> -#define MAX_MSG_LENGTH 66000
> +#define DEFAULT_MAX_PDU_SIZE 8300
> +
> +/* maximum PDU size before ISO 15765-2:2016 extension was 4095 */
> +#define MAX_12BIT_PDU_SIZE 4095
> +
> +/* limit the isotp pdu size from the optional module parameter to 1MByte=
 */
> +#define MAX_PDU_SIZE (1025 * 1024U)
> +
> +static unsigned int max_pdu_size __read_mostly =3D DEFAULT_MAX_PDU_SIZE;
> +module_param(max_pdu_size, uint, 0444);
> +MODULE_PARM_DESC(max_pdu_size, "maximum isotp pdu size (default "
> +		 __stringify(DEFAULT_MAX_PDU_SIZE) ")");
> =20
>  /* N_PCI type values in bits 7-4 of N_PCI bytes */
>  #define N_PCI_SF 0x00	/* single frame */
>  #define N_PCI_FF 0x10	/* first frame */
>  #define N_PCI_CF 0x20	/* consecutive frame */
> @@ -121,17 +132,19 @@ enum {
>  	ISOTP_WAIT_DATA,
>  	ISOTP_SENDING
>  };
> =20
>  struct tpcon {
> -	unsigned int idx;
> +	u8 *buf;
> +	unsigned int buflen;
>  	unsigned int len;
> +	unsigned int idx;
>  	u32 state;
>  	u8 bs;
>  	u8 sn;
>  	u8 ll_dl;
> -	u8 buf[MAX_MSG_LENGTH + 1];
> +	u8 sbuf[DEFAULT_MAX_PDU_SIZE];
>  };
> =20
>  struct isotp_sock {
>  	struct sock sk;
>  	int bound;
> @@ -501,11 +514,21 @@ static int isotp_rcv_ff(struct sock *sk, struct can=
fd_frame *cf, int ae)
>  	off =3D (so->rx.ll_dl > CAN_MAX_DLEN) ? 1 : 0;
> =20
>  	if (so->rx.len + ae + off + ff_pci_sz < so->rx.ll_dl)
>  		return 1;
> =20
> -	if (so->rx.len > MAX_MSG_LENGTH) {
> +	/* PDU size > default =3D> try max_pdu_size */

What exactly is "so->rx.len"?

> +	if (so->rx.len > so->rx.buflen && so->rx.buflen < max_pdu_size) {
                                          ^^^^^^^^^^^^^
Why are you checking so->rx.buflen against max_pdu_size? Should you
check rx.len instead?

> +		u8 *newbuf =3D kmalloc(max_pdu_size, GFP_ATOMIC);

In what context is this code executed? Is it really atomic?
Why are you allocating the max_pdu_size, not rx.len?

> +
> +		if (newbuf) {
> +			so->rx.buf =3D newbuf;
> +			so->rx.buflen =3D max_pdu_size;
> +		}
> +	}
> +
> +	if (so->rx.len > so->rx.buflen) {

This patch is also taken if the kmalloc() fails, right?

>  		/* send FC frame with overflow status */
>  		isotp_send_fc(sk, ae, ISOTP_FC_OVFLW);
>  		return 1;
>  	}
> =20
> @@ -805,11 +828,11 @@ static void isotp_create_fframe(struct canfd_frame =
*cf, struct isotp_sock *so,
>  	cf->len =3D so->tx.ll_dl;
>  	if (ae)
>  		cf->data[0] =3D so->opt.ext_address;
> =20
>  	/* create N_PCI bytes with 12/32 bit FF_DL data length */
> -	if (so->tx.len > 4095) {
> +	if (so->tx.len > MAX_12BIT_PDU_SIZE) {
>  		/* use 32 bit FF_DL notation */
>  		cf->data[ae] =3D N_PCI_FF;
>  		cf->data[ae + 1] =3D 0;
>  		cf->data[ae + 2] =3D (u8)(so->tx.len >> 24) & 0xFFU;
>  		cf->data[ae + 3] =3D (u8)(so->tx.len >> 16) & 0xFFU;
> @@ -945,11 +968,21 @@ static int isotp_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t size)
>  			goto err_out;
> =20
>  		so->tx.state =3D ISOTP_SENDING;
>  	}
> =20
> -	if (!size || size > MAX_MSG_LENGTH) {
> +	/* PDU size > default =3D> try max_pdu_size */
> +	if (size > so->tx.buflen && so->tx.buflen < max_pdu_size) {
> +		u8 *newbuf =3D kmalloc(max_pdu_size, GFP_KERNEL);

Same questions as in the RX-path. BTW: for the TX-path you can implement
something like in the j1939 protocol. There we don't allocate the full
TX buffer anymore, but handle it in chunks. Talk to Oleksij for details.

> +
> +		if (newbuf) {
> +			so->tx.buf =3D newbuf;
> +			so->tx.buflen =3D max_pdu_size;
> +		}
> +	}
> +
> +	if (!size || size > so->tx.buflen) {
>  		err =3D -EINVAL;
>  		goto err_out_drop;
>  	}
> =20
>  	/* take care of a potential SF_DL ESC offset for TX_DL > 8 */
> @@ -1193,10 +1226,16 @@ static int isotp_release(struct socket *sock)
>  	hrtimer_cancel(&so->rxtimer);
> =20
>  	so->ifindex =3D 0;
>  	so->bound =3D 0;
> =20
> +	if (so->rx.buf !=3D so->rx.sbuf)
> +		kfree(so->rx.buf);
> +
> +	if (so->tx.buf !=3D so->tx.sbuf)
> +		kfree(so->tx.buf);
> +
>  	sock_orphan(sk);
>  	sock->sk =3D NULL;
> =20
>  	release_sock(sk);
>  	sock_put(sk);
> @@ -1589,10 +1628,15 @@ static int isotp_init(struct sock *sk)
>  	so->tx.ll_dl =3D so->ll.tx_dl;
> =20
>  	so->rx.state =3D ISOTP_IDLE;
>  	so->tx.state =3D ISOTP_IDLE;
> =20
> +	so->rx.buf =3D so->rx.sbuf;
> +	so->tx.buf =3D so->tx.sbuf;
> +	so->rx.buflen =3D DEFAULT_MAX_PDU_SIZE;

what about: ARRAY_SIZE(so->rx.sbuf)

> +	so->tx.buflen =3D DEFAULT_MAX_PDU_SIZE;
> +
>  	hrtimer_init(&so->rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
>  	so->rxtimer.function =3D isotp_rx_timer_handler;
>  	hrtimer_init(&so->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
>  	so->txtimer.function =3D isotp_tx_timer_handler;
>  	hrtimer_init(&so->txfrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
> @@ -1656,11 +1700,14 @@ static struct notifier_block canisotp_notifier =
=3D {
> =20
>  static __init int isotp_module_init(void)
>  {
>  	int err;
> =20
> -	pr_info("can: isotp protocol\n");
> +	max_pdu_size =3D max_t(unsigned int, max_pdu_size, MAX_12BIT_PDU_SIZE);
> +	max_pdu_size =3D min_t(unsigned int, max_pdu_size, MAX_PDU_SIZE);
> +
> +	pr_info("can: isotp protocol (max_pdu_size %d)\n", max_pdu_size);
> =20
>  	err =3D can_proto_register(&isotp_can_proto);
>  	if (err < 0)
>  		pr_err("can: registration of isotp protocol failed %pe\n", ERR_PTR(err=
));
>  	else
> --=20
> 2.30.2
>=20
>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--4kqlnu2j3jl2hfjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQYiKMACgkQvlAcSiqK
BOjSkggAqh8Jxd5JA+Je81MITN/n1sAmzffkiGCrUIjY9KYVec50Q0Fkbgyn/EOW
nrHLOF+zoTE8curd/qu9LKEoug0US9Ik3ecyteP5WtX4RNUZsufzM8fY/EBZVVfz
pBK521+YAH/DDdJvP0358CmVy1K8KBxXEvidplyuEKMJrA1rp52Jxq3IJVDWJk6F
gOnfM5utld22C6RbsC0oBZeRvDbhI4kAUxDBKaXxxz+pDmOyaoUjI6k12/+N1lzo
ck6FJ3VusEN2nDyS3lKfiJTS3W4dAxTEx13PLJP4sNx/V3H2E3zUUnQbMMTKbCdR
mYq8yS9hTMcwP/t70FUMf9KXcOnKog==
=JuCQ
-----END PGP SIGNATURE-----

--4kqlnu2j3jl2hfjp--
