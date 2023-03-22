Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D386C4571
	for <lists+linux-can@lfdr.de>; Wed, 22 Mar 2023 09:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCVI4j (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 22 Mar 2023 04:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCVI4i (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 22 Mar 2023 04:56:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA175A6D6
        for <linux-can@vger.kernel.org>; Wed, 22 Mar 2023 01:56:37 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1peuGp-000556-Nk; Wed, 22 Mar 2023 09:56:35 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8B72019957A;
        Wed, 22 Mar 2023 08:56:34 +0000 (UTC)
Date:   Wed, 22 Mar 2023 09:56:33 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [RFC PATCH v2] can: isotp: add module parameter for maximum pdu
 size
Message-ID: <20230322085633.zwxip56fyr7qqguu@pengutronix.de>
References: <20230313172510.3851-1-socketcan@hartkopp.net>
 <20230320162406.5mkbvcmyx7nyqvjc@pengutronix.de>
 <c5451b95-5732-b3ed-38f5-1b09e74c0541@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gg3jzrlaygvfxckc"
Content-Disposition: inline
In-Reply-To: <c5451b95-5732-b3ed-38f5-1b09e74c0541@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--gg3jzrlaygvfxckc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.03.2023 22:07:56, Oliver Hartkopp wrote:
>=20
>=20
> On 20.03.23 17:24, Marc Kleine-Budde wrote:
> > On 13.03.2023 18:25:10, Oliver Hartkopp wrote:
> > > With ISO 15765-2:2016 the PDU size is not limited to 2^12 - 1 (4095) =
bytes
> > > but can be represented as a 32 bit unsigned integer value which allows
> > > 2^32 - 1 bytes (~4GB). The use-cases like automotive unified diagnost=
ic
> > > services (UDS) and flashing of ECUs still use the small static buffers
> > > which are provided at socket creation time.
> > >=20
> > > When a use-case requires to transfer PDUs up to 1025 kByte the maximum
> > > PDU size can now be extended by setting the module parameter max_pdu_=
size.
> > > The extended size buffers are only allocated on a per-socket/connecti=
on
> > > base when needed at run-time.
> > >=20
> > > Link: https://github.com/raspberrypi/linux/issues/5371
> > > Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >=20
> > See comments inline
> >=20
> > > ---
> > >=20
> > > v2: limit the minimum 'max_pdu_size' to 4095 to maintain the classic =
behavior
> > >      before ISO 15765-2:2016
> > >=20
> > > net/can/isotp.c | 65 ++++++++++++++++++++++++++++++++++++++++++-------
> > >   1 file changed, 56 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/net/can/isotp.c b/net/can/isotp.c
> > > index 9bc344851704..8a5d278c8bf1 100644
> > > --- a/net/can/isotp.c
> > > +++ b/net/can/isotp.c
> > > @@ -83,14 +83,25 @@ MODULE_ALIAS("can-proto-6");
> > >   			 (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG) : \
> > >   			 (CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG))
> > >   /* ISO 15765-2:2016 supports more than 4095 byte per ISO PDU as the=
 FF_DL can
> > >    * take full 32 bit values (4 Gbyte). We would need some good conce=
pt to handle
> > > - * this between user space and kernel space. For now increase the st=
atic buffer
> > > - * to something about 64 kbyte to be able to test this new functiona=
lity.
> > > + * this between user space and kernel space. For now set the static =
buffer to
> > > + * something about 8 kbyte to be able to test this new functionality.
> > >    */
> > > -#define MAX_MSG_LENGTH 66000
> > > +#define DEFAULT_MAX_PDU_SIZE 8300
> > > +
> > > +/* maximum PDU size before ISO 15765-2:2016 extension was 4095 */
> > > +#define MAX_12BIT_PDU_SIZE 4095
> > > +
> > > +/* limit the isotp pdu size from the optional module parameter to 1M=
Byte */
> > > +#define MAX_PDU_SIZE (1025 * 1024U)
> > > +
> > > +static unsigned int max_pdu_size __read_mostly =3D DEFAULT_MAX_PDU_S=
IZE;
> > > +module_param(max_pdu_size, uint, 0444);
> > > +MODULE_PARM_DESC(max_pdu_size, "maximum isotp pdu size (default "
> > > +		 __stringify(DEFAULT_MAX_PDU_SIZE) ")");
> > >   /* N_PCI type values in bits 7-4 of N_PCI bytes */
> > >   #define N_PCI_SF 0x00	/* single frame */
> > >   #define N_PCI_FF 0x10	/* first frame */
> > >   #define N_PCI_CF 0x20	/* consecutive frame */
> > > @@ -121,17 +132,19 @@ enum {
> > >   	ISOTP_WAIT_DATA,
> > >   	ISOTP_SENDING
> > >   };
> > >   struct tpcon {
> > > -	unsigned int idx;
> > > +	u8 *buf;
> > > +	unsigned int buflen;
> > >   	unsigned int len;
> > > +	unsigned int idx;
> > >   	u32 state;
> > >   	u8 bs;
> > >   	u8 sn;
> > >   	u8 ll_dl;
> > > -	u8 buf[MAX_MSG_LENGTH + 1];
> > > +	u8 sbuf[DEFAULT_MAX_PDU_SIZE];
> > >   };
> > >   struct isotp_sock {
> > >   	struct sock sk;
> > >   	int bound;
> > > @@ -501,11 +514,21 @@ static int isotp_rcv_ff(struct sock *sk, struct=
 canfd_frame *cf, int ae)
> > >   	off =3D (so->rx.ll_dl > CAN_MAX_DLEN) ? 1 : 0;
> > >   	if (so->rx.len + ae + off + ff_pci_sz < so->rx.ll_dl)
> > >   		return 1;
> > > -	if (so->rx.len > MAX_MSG_LENGTH) {
> > > +	/* PDU size > default =3D> try max_pdu_size */
> >=20
> > What exactly is "so->rx.len"?
> >=20
>=20
> This is the PDU size that is sent to this local host.
>=20
> > > +	if (so->rx.len > so->rx.buflen && so->rx.buflen < max_pdu_size) {
> >                                            ^^^^^^^^^^^^^
> > Why are you checking so->rx.buflen against max_pdu_size? Should you
> > check rx.len instead?
>=20
> if (to be received PDU does not fit into the rx-buffer AND the rx-buffer =
has
> not be extended to  max_pdu_size so far)
> {
> 	Try to increase the rx-buffer to max_pdu_size
> }
>=20
> >=20
> > > +		u8 *newbuf =3D kmalloc(max_pdu_size, GFP_ATOMIC);
> >=20
> > In what context is this code executed? Is it really atomic?
>=20
> Yes. In NET_RX softirq.

Ok

>=20
> > Why are you allocating the max_pdu_size, not rx.len?
>=20
> There is one upper limit which is selected when the 8300 bytes (99,9% of
> isotp use-cases) are not enough.
>=20
> I intentionally did not want to handle re-allocations for every increase =
of
> received PDU size on this socket.
>=20
> Just for simplicity reasons.

Hmmm. The worst case would be ~1MiB of contiguous kernel memory used, if
a 8301 bytes message would be send. That puts a lot of pressure on the
kernel memory for IMHO no good reason.

> > > +
> > > +		if (newbuf) {
> > > +			so->rx.buf =3D newbuf;
> > > +			so->rx.buflen =3D max_pdu_size;
> > > +		}
> > > +	}
> > > +
> > > +	if (so->rx.len > so->rx.buflen) {
> >=20
> > This patch is also taken if the kmalloc() fails, right?
>=20
> s/patch/path/ ?!

doh!

> Yes. At the end even the extended buffer might be too small. And when we
> don't have enough space - either with our without kmalloc() - it throws a=
nd
> error.
>=20
> For that reason a failed kmalloc() does not create any stress. We just st=
ay
> on the default buffer.

Just out of interest: How does ISOTP handle this situation? Is an error
message forwarded to the sender?

> > >   		/* send FC frame with overflow status */
> > >   		isotp_send_fc(sk, ae, ISOTP_FC_OVFLW);
> > >   		return 1;
> > >   	}
> > > @@ -805,11 +828,11 @@ static void isotp_create_fframe(struct canfd_fr=
ame *cf, struct isotp_sock *so,
> > >   	cf->len =3D so->tx.ll_dl;
> > >   	if (ae)
> > >   		cf->data[0] =3D so->opt.ext_address;
> > >   	/* create N_PCI bytes with 12/32 bit FF_DL data length */
> > > -	if (so->tx.len > 4095) {
> > > +	if (so->tx.len > MAX_12BIT_PDU_SIZE) {
> > >   		/* use 32 bit FF_DL notation */
> > >   		cf->data[ae] =3D N_PCI_FF;
> > >   		cf->data[ae + 1] =3D 0;
> > >   		cf->data[ae + 2] =3D (u8)(so->tx.len >> 24) & 0xFFU;
> > >   		cf->data[ae + 3] =3D (u8)(so->tx.len >> 16) & 0xFFU;
> > > @@ -945,11 +968,21 @@ static int isotp_sendmsg(struct socket *sock, s=
truct msghdr *msg, size_t size)
> > >   			goto err_out;
> > >   		so->tx.state =3D ISOTP_SENDING;
> > >   	}
> > > -	if (!size || size > MAX_MSG_LENGTH) {
> > > +	/* PDU size > default =3D> try max_pdu_size */
> > > +	if (size > so->tx.buflen && so->tx.buflen < max_pdu_size) {
> > > +		u8 *newbuf =3D kmalloc(max_pdu_size, GFP_KERNEL);
> >=20
> > Same questions as in the RX-path. BTW: for the TX-path you can implement
> > something like in the j1939 protocol. There we don't allocate the full
> > TX buffer anymore, but handle it in chunks. Talk to Oleksij for details.
>=20
> As explained above the reason for this buffer extension is a rare use-case
> that two people have been asking for in nine years.
>=20
> I've been thinking about some sendfile() implementation too. But this aga=
in
> would bloat the code and would not solve the rx side.

I'm not talking about sendfile. Have a look at j1939's
j1939_sk_send_loop();

| https://elixir.bootlin.com/linux/v6.2/source/net/can/j1939/socket.c#L1114

> Therefore this KISS approach seemed the right decision to me to provide s=
uch
> a feature for people who know what they are doing and who only tweak the
> module parameter on demand.
>=20
> >=20
> > > +
> > > +		if (newbuf) {
> > > +			so->tx.buf =3D newbuf;
> > > +			so->tx.buflen =3D max_pdu_size;
> > > +		}
> > > +	}
> > > +
> > > +	if (!size || size > so->tx.buflen) {
> > >   		err =3D -EINVAL;
> > >   		goto err_out_drop;
> > >   	}
> > >   	/* take care of a potential SF_DL ESC offset for TX_DL > 8 */
> > > @@ -1193,10 +1226,16 @@ static int isotp_release(struct socket *sock)
> > >   	hrtimer_cancel(&so->rxtimer);
> > >   	so->ifindex =3D 0;
> > >   	so->bound =3D 0;
> > > +	if (so->rx.buf !=3D so->rx.sbuf)
> > > +		kfree(so->rx.buf);
> > > +
> > > +	if (so->tx.buf !=3D so->tx.sbuf)
> > > +		kfree(so->tx.buf);
> > > +
> > >   	sock_orphan(sk);
> > >   	sock->sk =3D NULL;
> > >   	release_sock(sk);
> > >   	sock_put(sk);
> > > @@ -1589,10 +1628,15 @@ static int isotp_init(struct sock *sk)
> > >   	so->tx.ll_dl =3D so->ll.tx_dl;
> > >   	so->rx.state =3D ISOTP_IDLE;
> > >   	so->tx.state =3D ISOTP_IDLE;
> > > +	so->rx.buf =3D so->rx.sbuf;
> > > +	so->tx.buf =3D so->tx.sbuf;
> > > +	so->rx.buflen =3D DEFAULT_MAX_PDU_SIZE;
> >=20
> > what about: ARRAY_SIZE(so->rx.sbuf)
> >=20
>=20
> Looks good. I was just unsure which macro to use ;-)

You can also use sizeof(so->rx.sbuf).

ARRAY_SIZE would cause a compile error if you convert so->rx.sbuf to a
pointer to dynamically allocated mem, while sizeof() still compiles.

>=20
> > > +	so->tx.buflen =3D DEFAULT_MAX_PDU_SIZE;
> > > +
>=20
> here too. This would use the DEFAULT_MAX_PDU_SIZE at one single point. No
> chance to get these values out of sync.

ACK

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129  |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--gg3jzrlaygvfxckc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQawr4ACgkQvlAcSiqK
BOjLAggAnslRzta2f9GJYIl9PnG/oDUdsfrI6h17fdr7to+khxs8YfjyoBsq/Zbd
MRK2Hy8cY76kWDHxjGKtiGy6MCw4Qy3NrMl4Qb65RCM3nZdjdrVXBctWMzdGgBMF
F2Zs1T7B8vAhOMn6frcKwMf+dzmVOsLfyyKYieJC70D5d7QXUtkp05xIuIpqSBmx
RDfP99NCXpaMv+0/Wp9d8DtMFAF5HrHUtIaB+j02VXC83z/O+YdBiMLouQDlVBpy
qc2nIedYSab17SA5LsRZ9ufZKAo5PRRlC/UrVwMjlTqM4PpxKGFPhlCbW8VRFwfn
VriXh+2uhQBGWpyK3FBQVmAiRTQrBw==
=HD5K
-----END PGP SIGNATURE-----

--gg3jzrlaygvfxckc--
